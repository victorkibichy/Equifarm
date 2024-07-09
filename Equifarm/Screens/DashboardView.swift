import SwiftUI

struct DashboardView: View {
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 20) {
                    ForEach(0..<cardTitles.count) { index in
                        let title = cardTitles[index]
                        let imageName = imageNames[index]
                        
                        // Conditionally create NavigationLink based on the card title
                        if title == "My farm" {
                            CardView(title: title, imageName: imageName, destination: MyFarmView())
                        } else if title == "Produce" {
                            CardView(title: title, imageName: imageName, destination: ProduceView())
                        }
                            else if title == "Farm Tech" {
                                CardView(title: title, imageName: imageName, destination: FarmTechView())
                        }
                        else if title == "Farm inputs" {
                            CardView(title: title, imageName: imageName, destination: FarmInputsView())
                    }else {
                            CardView(title: title, imageName: imageName, destination: Text("\(title) View"))
                        }
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
    
    let cardTitles = ["My farm", "Farm inputs", "Produce", "Farm Tech", "Services", "Training", "Transport", "Insurance", "Support"]
    let imageNames = ["myfarm", "farminputs", "produce", "farmtech", "services", "training", "transport", "insurance", "support"]
}

struct CardView<Destination: View>: View {
    var title: String
    var imageName: String
    var destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("equifarm"))
            .cornerRadius(10)
            .shadow(radius: 5)
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
