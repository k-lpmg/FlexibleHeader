import UIKit

public class ProgressiveLayoutConstraintConstant {
    public let constraint: NSLayoutConstraint
    public let progress: CGFloat
    public let constant: CGFloat
    
    public init(constraint: NSLayoutConstraint, progress: CGFloat, constant: CGFloat) {
        self.constraint = constraint
        self.progress = progress
        self.constant = constant
    }
}
