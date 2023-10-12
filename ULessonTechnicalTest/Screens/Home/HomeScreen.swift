import SwiftUI
import Lottie

struct AlertMessage: Identifiable {
    var id: String { alert }
    let alert: String
}

struct HomeScreen: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var alert: AlertMessage?
    
    var body: some View {
        TabView {
            ScrollView {
                VStack(
                    spacing: 24
                ) {
                    HomeAd()
                    
                    HomeSearch(query: $viewModel.query)
                    
                    LazyVGrid(
                        columns: [GridItem(), GridItem(), GridItem(), GridItem()],
                        spacing: 24
                    ) {
                        ForEach(viewModel.subjects.filter { item in
                            viewModel.query.trimmingCharacters(in: .whitespaces).isEmpty || item.title.lowercased().contains(viewModel.query.trimmingCharacters(in: .whitespaces).lowercased())
                        }) { subject in
                            HomeSubject(subject: subject) {
                                viewModel.updateSubject(subject)
                                
                                if (subject.title != "Biology") {
                                    alert = AlertMessage(alert: "Only biology is available at the moment")
                                }
                            }
                        }
                    }
                }
                .padding()
                .overlay {
                    if (viewModel.overlayOpen) {
                        DailyLoginReward {
                            viewModel.dismissDailyLogin()
                        }.transition(.scale)
                    }
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            Text("Classes Content")
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Classes")
                }
            
            Text("Subscribe Content")
                .tabItem {
                    Image(systemName: "cart")
                    Text("Subscribe")
                }
            
            Text("Downloads Content")
                .tabItem {
                    Image(systemName: "square.and.arrow.down")
                    Text("Downloads")
                }
            
            Text("More Content")
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
        }
        .navigationDestination(isPresented: $viewModel.goToChapterDetails) {
            if (viewModel.selectedSubject != nil) {
                SubjectInfoScreen(subject: viewModel.selectedSubject!)
            }
        }
        .alert(item: $alert) { item in
            Alert(
                title: Text("Alert"),
                message: Text(item.alert),
                dismissButton: .default(Text("Okay"))
            )
        }
    }
}

#Preview {
    HomeScreen()
}
