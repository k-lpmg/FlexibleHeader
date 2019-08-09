import UIKit

class ThresholdFlexibleHeaderExecutant: FlexibleHeaderExecutant {
    
    // MARK: - Properties
    
    private let hiddenThreshold: CGFloat
    private let showThreshold: CGFloat
    private var prevOffsetY: CGFloat = 0.0
    private var prevProgress: CGFloat = 0.0
    
    // MARK: - Con(De)structor
    
    init(header: FlexibleHeader, hiddenThreshold: CGFloat = 20, showThreshold: CGFloat = 20) {
        self.hiddenThreshold = fmax(hiddenThreshold, 0.0)
        self.showThreshold = fmax(showThreshold, 0.0)
        super.init(header: header)
    }
    
    // MARK: - Overridden: FlexibleHeaderExecutant
    
    override func toBeChangedOffsetY(from scrollView: UIScrollView) -> CGFloat {
        return scrollView.contentOffset.y - prevOffsetY
    }
    
    override func toBeChangedProgress(from scrollView: UIScrollView) -> CGFloat {
        return prevProgress + super.toBeChangedProgress(from: scrollView)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let scrollViewViewportHeight = scrollView.bounds.maxY - scrollView.bounds.minY
        
        if (scrollView.contentOffset.y + scrollView.contentInset.top) >= 0.0 &&
            scrollView.contentOffset.y <= (scrollView.contentSize.height - scrollViewViewportHeight) {
            
            prevOffsetY = scrollView.contentOffset.y
            prevProgress = header.progress
            
            if (scrollView.contentOffset.y + scrollView.contentInset.top) > (showThreshold + (header.maxHeight - header.minHeight)) {
                applyShowThreshold()
            }
            if scrollView.contentOffset.y < (scrollView.contentSize.height - scrollViewViewportHeight - hiddenThreshold) {
                applyHiddenThreshold()
            }
            
        } else if (scrollView.contentOffset.y + scrollView.contentInset.top) < 0.0 {
            
            prevOffsetY = -scrollView.contentInset.top
            prevProgress = 0.0
            
            applyShowThreshold()
            applyHiddenThreshold()
            
        } else if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollViewViewportHeight) {
            
            if scrollView.contentSize.height > scrollViewViewportHeight {
                prevOffsetY = scrollView.contentSize.height - scrollViewViewportHeight
                prevProgress = 1.0
                
                applyShowThreshold()
                applyHiddenThreshold()
            }
            
        }
    }
    
    // MARK: - Private methods
    
    private func applyShowThreshold() {
        guard header.progress == 1.0 else {return}
        
        prevOffsetY -= showThreshold
    }
    
    private func applyHiddenThreshold() {
        guard header.progress == 0.0 else {return}
        
        prevOffsetY += hiddenThreshold
    }
    
}
