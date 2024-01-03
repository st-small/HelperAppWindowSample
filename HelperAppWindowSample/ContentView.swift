import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Present toast") {
                Toast.shared.present(
                    title: "No Network", 
                    message: "Failed to process request, no internet connection",
                    symbol: "xmark.circle.fill",
                    iconTint: .red,
                    isUserInteractionEnabled: true,
                    timing: .long
                )
            }
        }
        .padding()
    }
}

#Preview {
    RootView {
        ContentView()
    }
}
