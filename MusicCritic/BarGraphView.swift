// Alexis Murphy
// App Name: Music Critic
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
