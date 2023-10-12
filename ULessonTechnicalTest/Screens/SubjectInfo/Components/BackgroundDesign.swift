import SwiftUI

struct BackgroundDesign: View {
    var body: some View {
        ZStack(
            alignment: .topTrailing
        ) {
            Color.clear
            Image("home-splash")
                .resizable()
                .scaledToFit()
                .frame(height: 150, alignment: .topTrailing)
        }
    }
}

#Preview {
    BackgroundDesign()
}
