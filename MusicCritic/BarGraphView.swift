// Alexis Murphy alenmurp@iu.edu
// Briana Flores briflore@iu.edu
// App Name: Music Critic
// Submission Date: 4/24/2024
//
//  BarGraphView.swift
//
import SwiftUI

// incorporates UIKit with UIViewRepresentable
struct BarGraphView: UIViewRepresentable {
    var ratingsProportions: [CGFloat]

    // creates BarGraphUIView
    func makeUIView(context: Context) -> BarGraphUIView {
        let view = BarGraphUIView()
        return view
    }

    // updates when data changes
    func updateUIView(_ uiView: BarGraphUIView, context: Context) {
        uiView.ratingsProportions = ratingsProportions
    }
}
