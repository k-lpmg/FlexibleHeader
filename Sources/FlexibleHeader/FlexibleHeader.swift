import UIKit

open class FlexibleHeader: UIView {
    
    // MARK: - Typealias
    
    typealias ProgressiveViewValue = [CGFloat: ProgressiveViewAttribute]
    typealias ProgressiveLayoutConstraintValue = [CGFloat: CGFloat]
    
    // MARK: - Properties
    
    public private(set) var heightConstraint: NSLayoutConstraint!
    
    weak var scrollView: UIScrollView?
    weak var originalScrollDelegate: UIScrollViewDelegate?
    private(set) var headerExecutant: FlexibleHeaderExecutant!
    
    private var progressiveViews = [UIView: ProgressiveViewValue]()
    private var progressiveLayoutConstraints = [NSLayoutConstraint: ProgressiveLayoutConstraintValue]()
    
    // MARK: - Computed Properties
    
    public var maxHeight: CGFloat {
        get { return _maxHeight }
        set { _maxHeight = fmax(newValue, 0.0) }
    }
    public var minHeight: CGFloat {
        get { return _minHeight }
        set { _minHeight = fmax(newValue, 0.0) }
    }
    public private(set) var progress: CGFloat {
        get { return _progress }
        set { _progress = fmax(fmin(newValue, 1.0), 0.0) }
    }
    
    private var _maxHeight: CGFloat = 0.0
    private var _minHeight: CGFloat = 0.0
    private var _progress: CGFloat = 0.0
    
    // MARK: - Con(De)structor
    
    public init(scrollView: UIScrollView, maxHeight: CGFloat, minHeight: CGFloat, executantType: FlexibleHeaderExecutantType = .threshold) {
        super.init(frame: .zero)
        
        self.scrollView = scrollView
        originalScrollDelegate = scrollView.delegate
        scrollView.delegate = self
        
        self.maxHeight = maxHeight
        self.minHeight = minHeight
        
        switch executantType {
        case .normal:
            headerExecutant = FlexibleHeaderExecutant(header: self)
        case .threshold:
            headerExecutant = ThresholdFlexibleHeaderExecutant(header: self)
        case .customThreshold(let hiddenThreshold, let showThreshold):
            headerExecutant = ThresholdFlexibleHeaderExecutant(header: self, hiddenThreshold: hiddenThreshold, showThreshold: showThreshold)
        }
        
        setProperties()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        scrollView?.delegate = originalScrollDelegate
    }
    
    // MARK: - Overridden: UIView
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard heightConstraint != nil else { fatalError("heightConstraint is nil") }
        
        refreshLayoutConstraintConstant()
        heightConstraint?.constant = interpolate(from: maxHeight, to: minHeight, progress: progress)
        
        progress = fmax(progress, 0.0)
        refreshViewAttributes()
    }
    
    // MARK: - Public methods
    
    public func appendProgressiveViewAttribute(with attribute: ProgressiveViewAttribute) {
        if progressiveViews[attribute.view] == nil {
            progressiveViews[attribute.view] = ProgressiveViewValue()
        }
        
        progressiveViews[attribute.view]?[attribute.progress] = attribute
    }
    
    public func removeProgressiveSubviewAttribute(with attribute: ProgressiveViewAttribute) {
        progressiveViews[attribute.view]?[attribute.progress] = nil
    }
    
    public func appendProgressiveConstraintConstant(with layoutConstraintConstant: ProgressiveLayoutConstraintConstant) {
        if progressiveLayoutConstraints[layoutConstraintConstant.constraint] == nil {
            progressiveLayoutConstraints[layoutConstraintConstant.constraint] = ProgressiveLayoutConstraintValue()
        }
        
        let newProgress = fmax(fmin(layoutConstraintConstant.progress, 1.0), 0.0)
        progressiveLayoutConstraints[layoutConstraintConstant.constraint]?[newProgress] = layoutConstraintConstant.constant
    }
    
    public func removeConstraintConstant(with layoutConstraintConstant: ProgressiveLayoutConstraintConstant) {
        progressiveLayoutConstraints[layoutConstraintConstant.constraint]?[layoutConstraintConstant.progress] = nil
    }
    
    public func configure(heightConstraint: NSLayoutConstraint) {
        self.heightConstraint = heightConstraint
    }
    
    // MARK: - Internal methods
    
    func setProgress(with newProgress: CGFloat) {
        progress = newProgress
    }
    
}

// MARK: - Private methods

extension FlexibleHeader {
    
    private func setProperties() {
        backgroundColor = UIColor(red: 232/255, green: 233/255, blue: 237/255, alpha: 1)
    }
    
    private func refreshViewAttributes() {
        func apply(floorLayoutAttributes: ProgressiveViewAttribute, ceilingLayoutAttributes: ProgressiveViewAttribute, subview: UIView, floorProgress: CGFloat, ceilingProgress: CGFloat) {
            let relativeProgress = calculateRelativeProgress(floorProgress: floorProgress, ceilingProgress: ceilingProgress)
            subview.alpha = interpolate(from: floorLayoutAttributes.alpha, to: ceilingLayoutAttributes.alpha, progress: relativeProgress)
            subview.layer.cornerRadius = interpolate(from: floorLayoutAttributes.cornerRadius, to: ceilingLayoutAttributes.cornerRadius, progress: relativeProgress)
        }
        
        for (subview, _) in progressiveViews {
            guard let keys = progressiveViews[subview]?.keys else {return}
            
            var progAttrKeys = Array(keys)
            progAttrKeys.sort(){ $0<$1 }
            progAttrKeys.enumerated().forEach({ (index, _) in
                let floorProgressPosition = progAttrKeys[index]
                
                if index + 1 < progAttrKeys.count {
                    let ceilingProgressPosition = progAttrKeys[index + 1]
                    if progress >= floorProgressPosition && progress < ceilingProgressPosition {
                        if let floor = progressiveViews[subview]?[floorProgressPosition], let ceiling = progressiveViews[subview]?[ceilingProgressPosition] {
                            apply(floorLayoutAttributes: floor, ceilingLayoutAttributes: ceiling, subview: subview, floorProgress: floorProgressPosition, ceilingProgress: ceilingProgressPosition)
                        }
                    }
                } else {
                    if progress >= floorProgressPosition {
                        if let floor = progressiveViews[subview]?[floorProgressPosition] {
                            apply(floorLayoutAttributes: floor, ceilingLayoutAttributes: floor, subview: subview, floorProgress: floorProgressPosition, ceilingProgress: floorProgressPosition)
                        }
                    }
                }
            })
        }
    }
    
    private func refreshLayoutConstraintConstant() {
        for (constraint, _) in progressiveLayoutConstraints {
            guard let keys = progressiveLayoutConstraints[constraint]?.keys else {return}
            
            var progConstKeys = Array(keys)
            progConstKeys.sort(){ $0<$1 }
            progConstKeys.enumerated().forEach({ (index, _) in
                let floorProgressPosition = progConstKeys[index]
                
                if index + 1 < progConstKeys.count {
                    let ceilingProgressPosition = progConstKeys[index + 1]
                    if progress >= floorProgressPosition && progress < ceilingProgressPosition {
                        if let floor = progressiveLayoutConstraints[constraint]?[floorProgressPosition], let ceiling = progressiveLayoutConstraints[constraint]?[ceilingProgressPosition] {
                            let relativeProgress = calculateRelativeProgress(floorProgress: floorProgressPosition, ceilingProgress: ceilingProgressPosition)
                            constraint.constant = interpolate(from: floor, to: ceiling, progress: relativeProgress)
                        }
                    }
                } else {
                    if progress >= floorProgressPosition {
                        if let floor = progressiveLayoutConstraints[constraint]?[floorProgressPosition] {
                            let relativeProgress = calculateRelativeProgress(floorProgress: floorProgressPosition, ceilingProgress: floorProgressPosition)
                            constraint.constant = interpolate(from: floor, to: floor, progress: relativeProgress)
                        }
                    }
                }
            })
        }
    }
    
    private func calculateRelativeProgress(floorProgress: CGFloat, ceilingProgress: CGFloat) -> CGFloat {
        let numerator = progress - floorProgress
        let denominator: CGFloat
        if ceilingProgress == floorProgress {
            denominator = ceilingProgress
        } else {
            denominator = ceilingProgress - floorProgress
        }
        return numerator / denominator
    }
    
    private func interpolate(from: CGFloat, to: CGFloat, progress: CGFloat) -> CGFloat {
        return from - ((from - to) * progress)
    }
    
}
