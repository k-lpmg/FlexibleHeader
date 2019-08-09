import UIKit

extension FlexibleHeader: UIScrollViewDelegate {
    
    // MARK: - Scroll & Zoom
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        defer {
            headerExecutant.scrollViewDidScroll(scrollView)
        }
        
        originalScrollDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        originalScrollDelegate?.scrollViewDidZoom?(scrollView)
    }
    
    // MARK: - Dragging
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        defer {
            headerExecutant.scrollViewWillBeginDragging(scrollView)
        }
        
        originalScrollDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        originalScrollDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        defer {
            headerExecutant.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        }
        
        originalScrollDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    // MARK: - Decelerating
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        originalScrollDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        defer {
            headerExecutant.scrollViewDidEndDecelerating(scrollView)
        }
        
        originalScrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    // MARK: - ScrollingAnimation
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        originalScrollDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    // MARK: - Zooming
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return originalScrollDelegate?.viewForZooming?(in: scrollView)
    }
    
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        originalScrollDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        originalScrollDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
    }
    
    // MARK: - ScrollToTop
    
    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return originalScrollDelegate?.scrollViewShouldScrollToTop?(scrollView) == true
    }
    
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        originalScrollDelegate?.scrollViewDidScrollToTop?(scrollView)
    }
    
    // MARK: - AdjustedContentInset
    
    @available(iOS 11.0, *)
    public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        originalScrollDelegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
    }
    
}
