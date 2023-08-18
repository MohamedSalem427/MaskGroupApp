//
//  Extension+UIViewController.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 03/08/2023.
//

import UIKit
import SwiftUI
public extension UIViewController {
    func present<Content: View>(
            presentationStyle: UIModalPresentationStyle = .fullScreen,
            transitionStyle: UIModalTransitionStyle = .coverVertical,
            animated: Bool = true,
            completion: @escaping () -> Void = {
            },
            @ViewBuilder builder: () -> Content) {
        let toPresent = HostingController(rootView: builder())
        if presentationStyle == .overCurrentContext {
            toPresent.view.backgroundColor = .clear
        }
        toPresent.modalPresentationStyle = presentationStyle
        present(toPresent, animated: animated, completion: completion)
    }

    func push<Content: View>(
            presentationStyle: UIModalPresentationStyle = .fullScreen,
            transitionStyle: UIModalTransitionStyle = .coverVertical,
            animated: Bool = true,
            completion: @escaping () -> Void = {
            },
            @ViewBuilder builder: () -> Content) {
        let toPresent = HostingController(rootView: builder())
        if presentationStyle == .overCurrentContext {
            toPresent.view.backgroundColor = .clear
        }
        toPresent.modalPresentationStyle = presentationStyle
        navigationController?.pushViewController(toPresent, animated: true)
    }
}
class HostingController<Content>: UIHostingController<Content> where Content: View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
