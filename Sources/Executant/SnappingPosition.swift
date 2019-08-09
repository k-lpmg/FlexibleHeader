import CoreFoundation

extension FlexibleHeaderExecutant {
    
    struct SnappingPosition {
        let progress: CGFloat
        let range: NSRange
        
        init(progress: CGFloat, start: CGFloat, end: CGFloat) {
            self.progress = progress
            
            let newStart = fmax(fmin(start, 1.0), 0.0) * 100.0
            let newEnd = fmax(fmin(end, 1.0), 0.0) * 100.0
            range = NSRange(location: Int(newStart), length: Int(newEnd - newStart))
        }
    }
    
}
