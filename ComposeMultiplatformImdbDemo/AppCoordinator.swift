import SwiftUI

/// The iOS client owns its own navigation. The five SDK screens are
/// explicit SwiftUI Views (defined in `Screens/SdkScreens.swift`) that
/// internally bridge to the Compose Multiplatform rendering surface.
/// The `UIViewControllerRepresentable` plumbing is hidden behind each
/// View's `body` — the call site here sees only standard SwiftUI types.
///
/// This is a TabView, but the same Views would work just as well inside
/// a `NavigationStack` as `navigationDestination` targets.
struct AppCoordinator: View {
    @State private var selection: Int = UserDefaults.standard.integer(forKey: "initialTab")

    var body: some View {
        TabView(selection: $selection) {
            HomeScreen()
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)

            MoviesScreen()
                .tabItem { Label("Movies", systemImage: "film") }
                .tag(1)

            TVShowsScreen()
                .tabItem { Label("TV", systemImage: "tv") }
                .tag(2)

            SearchScreen()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(3)

            TrendingScreen()
                .tabItem { Label("Trending", systemImage: "flame") }
                .tag(4)
        }
    }
}
