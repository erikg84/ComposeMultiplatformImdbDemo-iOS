import SwiftUI

/// Explicit SwiftUI Views that host each SDK Compose screen.
///
/// The auto-generated `*Representable` structs in `Wrappers/` conform to
/// `UIViewControllerRepresentable` — that's an Apple API requirement for
/// bridging a UIViewController (which is what Compose Multiplatform renders
/// into via Skia/Metal) into the SwiftUI view tree. These thin View wrappers
/// hide that implementation detail so the rest of the app only sees
/// standard `struct: View` types.

public struct HomeScreen: View {
    public var body: some View {
        HomeScreenRepresentable()
            .ignoresSafeArea(.keyboard)
    }
}

public struct MoviesScreen: View {
    public var body: some View {
        MoviesScreenRepresentable()
            .ignoresSafeArea(.keyboard)
    }
}

public struct TVShowsScreen: View {
    public var body: some View {
        TVShowsScreenRepresentable()
            .ignoresSafeArea(.keyboard)
    }
}

public struct SearchScreen: View {
    public var body: some View {
        SearchScreenRepresentable()
            .ignoresSafeArea(.keyboard)
    }
}

public struct TrendingScreen: View {
    public var body: some View {
        TrendingScreenRepresentable()
            .ignoresSafeArea(.keyboard)
    }
}
