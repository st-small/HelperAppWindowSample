import SwiftUI

struct ToastView: View {
    var size: CGSize
    var item: ToastItem
    
    /// View Properties
    @State private var delayTask: DispatchWorkItem?
    
    var body: some View {
        HStack(spacing: 0) {
            if let symbol = item.symbol {
                Image(systemName: symbol)
                    .font(.title3)
                    .padding(.trailing, 10)
                    .foregroundStyle(item.iconTint)
            }
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                
                if let message = item.message {
                    Text(message)
                        .font(.system(size: 16, weight: .regular))
                        .lineLimit(2)
                        .opacity(0.5)
                }
            }
            
            Spacer()
        }
        .foregroundStyle(item.tint)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(
            .background
                .shadow(.drop(color: .primary.opacity(0.06), radius: 5, x: 5, y: 5))
                .shadow(.drop(color: .primary.opacity(0.06), radius: 8, x: -5, y: -5)),
            in: RoundedRectangle(cornerRadius: 10)
        )
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { value in
                    guard item.isUserInteractionEnabled else { return }
                    let endY = value.translation.height
                    let velocityY = value.velocity.height
                    
                    if (endY + velocityY) > 100 {
                        /// Removing Toast
                        removeToast()
                    }
                }
        )
        .onAppear {
            guard delayTask == nil else { return }
            delayTask = .init(block: {
                removeToast()
            })
            
            if let delayTask {
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + item.timing.rawValue,
                    execute: delayTask
                )
            }
        }
        /// Limiting Size
        .frame(maxWidth: size.width - 20)
        .transition(.offset(y: 150))
    }
    
    private func removeToast() {
        if let delayTask {
            delayTask.cancel()
        }
        withAnimation(.snappy) {
            Toast.shared.toasts.removeAll(where: { $0.id == item.id })
        }
    }
}
