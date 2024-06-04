// Alexis Murphy
// App Name: Music Critic
//
//  BarGraphUIView.swift
//

import UIKit

// uses CoreGraphics to create a bar graph that shows how the proportion of total ratings are distributed
class BarGraphUIView: UIView {
    var ratingsProportions: [CGFloat] = [] {
            didSet {
                self.setNeedsDisplay()  // redraws when data is changed
        }
    }
    
    // draws the bar graph
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        if context == nil {
            return
        }

        context!.setFillColor(UIColor.white.cgColor)
        context!.fill(rect)

        let maxWidth = rect.width
        let maxHeight = rect.height - 20
        let barWidth = maxWidth / CGFloat(ratingsProportions.count)
        let padding: CGFloat = 10

        var total: CGFloat = 0
        for proportion in ratingsProportions {
            total += proportion
        }

        var index = 0
        for proportion in ratingsProportions {
            let normalizedProportion = proportion / total
            let barHeight = (maxHeight - padding) * normalizedProportion
            let x = CGFloat(index) * barWidth + padding / 2
            let y = maxHeight - barHeight

            context!.setFillColor(UIColor.systemIndigo.cgColor)
            context!.fill(CGRect(x: x, y: y, width: barWidth - padding, height: barHeight))

            let numberString = "\(index + 1)" as NSString
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.black
            ]
            let stringSize = numberString.size(withAttributes: attributes)
            let stringY = maxHeight + 5

            numberString.draw(in: CGRect(x: x + (barWidth - padding) / 2 - stringSize.width / 2, y: stringY, width: stringSize.width, height: stringSize.height), withAttributes: attributes)

            index += 1
        }
    }
}

