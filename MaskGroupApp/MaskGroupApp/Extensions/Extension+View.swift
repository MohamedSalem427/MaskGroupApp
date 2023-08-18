//
//  extension+view.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 03/08/2023.
//

import UIKit
import SwiftUI

extension View {
    var controller: UIViewController? { UIApplication.shared.topController }
}
public extension View {
    var viewController: UIViewController? {
        UIApplication.shared.windows.first?.rootViewController
    }
}

public extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
                .mask(CornerRadiusShape(radius: radius, corners: corners))
    }
}
