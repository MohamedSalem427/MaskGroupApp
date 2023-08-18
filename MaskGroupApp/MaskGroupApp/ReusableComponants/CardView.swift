//
//  CardView.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 03/08/2023.
//

import SwiftUI

public struct CardView: ViewModifier {
    var opacity: CGFloat?
    var cornerRadius: CGFloat?
    var shadowRadius: CGFloat?
    
    public init(opacity: CGFloat?,cornerRadius: CGFloat?,shadowRadius: CGFloat?) {
        self.opacity = opacity
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
    }

    public func body(content: Content) -> some View {
        content
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius ?? 5, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(opacity ?? 0.2), radius: shadowRadius ?? 0.6)

        )
    }

}

public extension View {
    func cardView(opacity: CGFloat? = 0.2, cornerRadius: CGFloat? = 5, shadowRadius: CGFloat? = 0.6) -> some View {
        modifier(CardView(opacity: opacity, cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
}
