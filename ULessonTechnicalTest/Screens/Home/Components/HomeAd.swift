import SwiftUI

struct HomeAd: View {
    var body: some View {
        Image("ad")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius:  16.0))
    }
}

#Preview {
    HomeAd()
}
