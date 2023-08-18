//
//  ActivityIndicator.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 18/08/2023.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = Alert
        
    @Binding var isAnimating: Bool
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> Alert {
        return Alert()
    }
    
    func updateUIView(_ uiView: Alert, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startLoading() : uiView.stopLoading()
    }
    
    static func dismantleUIView(_ uiView: Alert, coordinator: ()) {
        
    }
}

struct ActivityIndicatorModifier: ViewModifier {
    @ObservedObject var loadingState: LoadingState
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                content
                    .disabled(loadingState.isLoading)
                if loadingState.isLoading {
                    ActivityIndicator(isAnimating: $loadingState.isLoading)
                }
            }
        }
    }
}

extension View {
    func activityIndicator(loadingState: LoadingState) -> some View {
        modifier(ActivityIndicatorModifier(loadingState: loadingState))
    }
}

protocol LoadingStateProtocol {
    var isLoading: Bool { get set }
}

class LoadingState: ObservableObject, LoadingStateProtocol {
    @Published var isLoading: Bool = false
}
