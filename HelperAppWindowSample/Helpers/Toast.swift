import SwiftUI

@Observable
class Toast {
    static let shared = Toast()
    var toasts: [ToastItem] = []
    
    func present(
        title: String,
        message: String? = nil,
        symbol: String?,
        tint: Color = .primary,
        iconTint: Color = .primary,
        isUserInteractionEnabled: Bool = false,
        timing: ToastTime = .medium
    ) {
        withAnimation(.snappy) {
            toasts.append(
                .init(
                    title: title,
                    message: message,
                    symbol: symbol,
                    tint: tint,
                    iconTint: iconTint,
                    isUserInteractionEnabled: isUserInteractionEnabled,
                    timing: timing
                )
            )
        }
    }
}

struct ToastItem: Identifiable {
    let id: UUID = .init()
    /// Custom Properties
    var title: String
    var message: String?
    var symbol: String?
    var tint: Color
    var iconTint: Color
    var isUserInteractionEnabled: Bool
    /// Timing
    var timing: ToastTime = .medium
}

enum ToastTime: CGFloat {
    case short = 1.0
    case medium = 2.0
    case long = 3.5
}
