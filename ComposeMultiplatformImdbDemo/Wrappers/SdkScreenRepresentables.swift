import SwiftUI
import UIKit
import ImdbSDK

// ─────────────────────────────────────────────────────────────────────────────
//  SDK screen wrappers
//
//  Each SDK screen is exposed by `imdb-sdk` as a Kotlin function in iosMain
//  that returns a `UIViewController` containing the Compose UI. Bridging
//  those to SwiftUI takes ~7 lines per screen — five screens, ~35 LoC total.
//
//  We chose hand-written wrappers over the KMP-ComposeUIViewController
//  KSP plugin because:
//  - This SDK is in a separate repo from both clients (the plugin's
//    auto-export targets a sibling iosApp/ directory in a monorepo)
//  - Five screens is below the threshold where code-gen pays off
//  - The wrappers are mechanical and only need editing if we add screens
//
//  SKIE makes the call site cleaner on the Kotlin↔Swift boundary
//  (Flow → AsyncSequence, suspend → async) but the actual factory
//  invocations are plain `ViewControllerFactoriesKt.<name>ViewController()`.
// ─────────────────────────────────────────────────────────────────────────────

struct HomeScreenRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ViewControllerFactoriesKt.homeViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct MoviesScreenRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ViewControllerFactoriesKt.moviesViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct TVShowsScreenRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ViewControllerFactoriesKt.tvShowsViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct SearchScreenRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ViewControllerFactoriesKt.searchViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct TrendingScreenRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ViewControllerFactoriesKt.trendingViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
