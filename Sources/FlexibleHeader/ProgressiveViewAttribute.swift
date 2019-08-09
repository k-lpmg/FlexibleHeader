import UIKit

public class ProgressiveViewAttribute {
    public let view: UIView
    public var progress: CGFloat {
        get { return _progress }
        set { _progress = fmax(fmin(newValue, 1.0), 0.0) }
    }
    public var alpha: CGFloat = 0.0
    public var cornerRadius: CGFloat {
        get { return _cornerRadius }
        set { _cornerRadius = fmax(newValue, 0.0) }
    }
    
    private var _progress: CGFloat = 0.0
    private var _cornerRadius: CGFloat = 0.0
    
    public init(view: UIView, progress: CGFloat, alpha: CGFloat, cornerRadius: CGFloat = 0.0) {
        self.view = view
        self.progress = progress
        self.alpha = alpha
        self.cornerRadius = cornerRadius
    }
}
