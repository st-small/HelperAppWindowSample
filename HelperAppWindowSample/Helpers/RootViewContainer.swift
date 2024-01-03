import SwiftUI

/// Root View for Creating Overlay Window
struct RootView<Content: View>: View {
    @ViewBuilder var content: Content
    
    /// View Properties
    @State private var overlayWindow: UIWindow?
    
    var body: some View {
        content
            .onAppear {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, overlayWindow == nil {
                    let window = PassthroughWindow(windowScene: windowScene)
                    window.backgroundColor = .clear
                    /// View Controller
                    let rootController = UIHostingController(rootView: ToastGroup())
                    rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
                    rootController.view.backgroundColor = .clear
                    window.rootViewController = rootController
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    window.tag = 777
                    
                    overlayWindow = window
                }
            }
    }
}

final class PassthroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        
        return rootViewController?.view == view ? nil : view
    }
}
