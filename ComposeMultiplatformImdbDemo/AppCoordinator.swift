import SwiftUI
import ImdbSDK

/// The iOS client owns its own navigation. The five SDK screens are
/// SwiftUI Views shipped INSIDE ImdbSDK.framework — built by SKIE's
/// Swift Code Bundling from `src/iosMain/swift/SdkScreenViews.swift`
/// in the SDK repo. No wrapper code lives in this client repo at all.
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
