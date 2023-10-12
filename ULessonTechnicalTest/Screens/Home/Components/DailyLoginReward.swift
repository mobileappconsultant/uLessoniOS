import SwiftUI
import Lottie

struct DailyLoginReward: View {
    
    let onClick: () -> Void
    
    var body: some View {
        VStack {
            VStack(
                spacing: 20
            ) {
                LottieView(animation: .named("reward"))
                    .playing()
                    .resizable()
                    .frame(height: 200)
                
                Text("Daily Login Reward")
                    .font(.title2)
                    .bold()
                
                Text("You have received the Gold badge for logging in today. Log in every day to get even more awesome rewards 😉")
                    .multilineTextAlignment(.center)
                
                Divider()
                
                Button("Okay", action: onClick)
            }
            .padding()
            .frame(
                minWidth: 0,
                maxWidth: .infinity
            )
            .padding()
            .background(.regularMaterial)
            .cornerRadius(16.0)
        }.padding()
    }
}

#Preview {
    DailyLoginReward {
        
    }
}
