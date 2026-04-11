import SwiftUI

/// The iOS client owns its own navigation. The five SDK screens are dropped
/// in as `UIViewControllerRepresentable` wrappers — one per tab. Inside each
/// tab the client is free to push native SwiftUI screens, deep-link, or
/// stack additional SDK screens; the SDK doesn't know or care.
///
/// This is a TabView, but the same Representables would work just as well
/// inside a `NavigationStack` as `navigationDestination` targets — see the
/// `AppRoute`-driven pattern in the README for that variant.
struct AppCoordinator: View {
    @State private var selection: Int = UserDefaults.standard.integer(forKey: "initialTab")

    var body: some View {
        TabView(selection: $selection) {
            HomeScreenRepresentable()
                .ignoresSafeArea(.keyboard)
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)

            MoviesScreenRepresentable()
                .ignoresSafeArea(.keyboard)
                .tabItem { Label("Movies", systemImage: "film") }
                .tag(1)

            TVShowsScreenRepresentable()
                .ignoresSafeArea(.keyboard)
                .tabItem { Label("TV", systemImage: "tv") }
                .tag(2)

            SearchScreenRepresentable()
                .ignoresSafeArea(.keyboard)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(3)

            TrendingScreenRepresentable()
                .ignoresSafeArea(.keyboard)
                .tabItem { Label("Trending", systemImage: "flame") }
                .tag(4)
        }
    }
}
