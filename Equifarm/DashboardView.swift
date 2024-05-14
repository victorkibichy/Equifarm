import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 20) {
                    ForEach(0..<9) { index in
                        CardView(title: cardTitles[index], imageName: imageNames[index])
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("equifarm"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
                .padding(20)
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    DrawerMenuButton()
                }
            }
        }
    }
    
    let cardTitles = ["My farm", "Farm inputs", "Produce", "Farm Tech", "Services", "Training", "Transportation", "Insurance", "Support"]
    let imageNames = ["myfarm", "farminputs", "produce", "farmtech", "services", "training", "transport", "insurance", "support"]
}

struct CardView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
            
            Text(title)
                .foregroundColor(.black)
                .font(.headline)
                .padding()
                .fontWeight(.semibold)
        }
    }
}

struct DrawerMenuButton: View {
    var body: some View {
        NavigationLink(destination: DrawerMenuView()) {
            Image(systemName: "line.horizontal.3")
                .font(.title)
                .foregroundColor(.black)
                .padding()
        }
    }
}

struct DrawerMenuView: View {
    @State private var selectedMenuItem: MenuItem? = nil
    
    var body: some View {
        List {
            ForEach(MenuItem.allCases, id: \.self) { item in
                NavigationLink(destination: item.destinationView, tag: item, selection: $selectedMenuItem) {
                    Text(item.rawValue)
                }
            }
        }
        .navigationTitle("Menu")
    }
}

enum MenuItem: String, CaseIterable {
    case home = "Home"
    case myAccount = "My Account"
    case settings = "Settings"
    case logout = "Logout"
    
    var destinationView: some View {
        switch self {
        case .home:
            return AnyView(DashboardView())
        case .myAccount:
            return AnyView(MyAccountView())
        case .settings:
            return AnyView(SettingsView())
        case .logout:
            return AnyView(LogoutView())
        }
    }
}



struct HomeView: View {
    var body: some View {
        Text("Home View")
    }
}

struct MyAccountView: View {
    var body: some View {
        Text("My Account View")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings View")
    }
}



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
