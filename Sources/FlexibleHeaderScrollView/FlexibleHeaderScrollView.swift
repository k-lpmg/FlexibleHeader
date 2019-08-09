import UIKit

open class FlexibleHeaderScrollView: UIView {
    
    // MARK: - UI Components
    
    public let header: FlexibleHeader
    public let scrollView: UIScrollView
    public let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerMaxHeight: CGFloat
    private let headerMinHeight: CGFloat
    private let headerExecutantType: FlexibleHeaderExecutantType
    
    // MARK: - Con(De)structor
    
    public init(headerMaxHeight: CGFloat, headerMinHeight: CGFloat, headerExecutantType: FlexibleHeaderExecutantType = .threshold) {
        self.headerMaxHeight = headerMaxHeight
        self.headerMinHeight = headerMinHeight
        self.headerExecutantType = headerExecutantType
        
        scrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        header = FlexibleHeader(scrollView: scrollView, maxHeight: headerMaxHeight, minHeight: headerMinHeight, executantType: headerExecutantType)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: .zero)
        
        setProperties()
        addSubview(header)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        layout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        backgroundColor = .white
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
}

// MARK: Layout

extension FlexibleHeaderScrollView {
    
    private func layout() {
        header.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        let flexibleHeaderHeight = header.heightAnchor.constraint(equalToConstant: 50)
        flexibleHeaderHeight.isActive = true
        header.configure(heightConstraint: flexibleHeaderHeight)
        
        scrollView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        layoutScrollView()
    }
    
    private func layoutScrollView() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
}
