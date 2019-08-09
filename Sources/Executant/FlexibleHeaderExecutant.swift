import UIKit

class FlexibleHeaderExecutant: NSObject {
    
    // MARK: - Properties
    
    unowned let header: FlexibleHeader
    
    private var currentlySnapping = false
    private var snappingPositions = [NSRange: CGFloat]()
    
    // MARK: - Con(De)structor
    
    init(header: FlexibleHeader) {
        self.header = header
        super.init()
        
        addSnappingPosition(with: .init(progress: 0.0, start: 0.0, end: 40.0/(105.0 - 20.0)))
        addSnappingPosition(with: .init(progress: 1.0, start: 40.0/(105.0 - 20.0), end: 1.0))
    }
    
    // MARK: - Internal methods
    
    func toBeChangedOffsetY(from scrollView: UIScrollView) -> CGFloat {
        return scrollView.contentOffset.y
    }
    
    func toBeChangedProgress(from scrollView: UIScrollView) -> CGFloat {
        return toBeChangedOffsetY(from: scrollView) / (header.maxHeight - header.minHeight)
    }
    
    // MARK: - Private methods
    
    private func addSnappingPosition(with snappingPosition: SnappingPosition) {
        defer {
            snappingPositions[snappingPosition.range] = snappingPosition.progress
        }
        
        for (range, _) in snappingPositions {
            let noRangeConflict = NSIntersectionRange(snappingPosition.range, range).length == 0
            assert(noRangeConflict, "SnappingPosition conflict")
        }
    }
    
    private func removeSnappingPosition(with snappingPosition: SnappingPosition) {
        snappingPositions.removeValue(forKey: snappingPosition.range)
    }
    
}

// MARK: - UIScrollViewDelegate

extension FlexibleHeaderExecutant: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snap(with: scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else {return}
        
        snap(with: scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !currentlySnapping else {return}
        
        header.setProgress(with: toBeChangedProgress(from: scrollView))
        header.setNeedsLayout()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
}

// MARK: - Private methods

extension FlexibleHeaderExecutant {
    
    private func snap(with scrollView: UIScrollView) {
        guard !currentlySnapping && header.progress >= 0 else {return}
        
        currentlySnapping = true
        
        var snapPosition = CGFloat(MAXFLOAT)
        for (range, progress) in snappingPositions {
            let progressPercent = header.progress * 100.0
            if progressPercent >= CGFloat(range.location) && progressPercent <= CGFloat(range.location + range.length) {
                snapPosition = progress
            }
        }
        
        if snapPosition != CGFloat(MAXFLOAT) {
            UIView.animate(withDuration: 0.15, animations: {
                self.snap(to: snapPosition, scrollView: scrollView)
            }, completion: { flag in
                self.currentlySnapping = false
            })
        } else {
            currentlySnapping = false
        }
    }
    
    private func snap(to progress: CGFloat, scrollView: UIScrollView) {
        defer {
            currentlySnapping = false
        }
        
        let deltaProgress = progress - header.progress
        let deltaOffsetY = (header.maxHeight - header.minHeight) * deltaProgress
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + deltaOffsetY)
        
        header.setProgress(with: progress)
        header.setNeedsLayout()
        header.layoutIfNeeded()
    }
    
}
