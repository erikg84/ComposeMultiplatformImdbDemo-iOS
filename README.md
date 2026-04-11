# ComposeMultiplatformImdbDemo — iOS client

A SwiftUI app that consumes the [composemultiplatformsdk](https://github.com/erikg84/composemultiplatformsdk) shared SDK and embeds its 5 Compose Multiplatform screens via 5 small `UIViewControllerRepresentable` wrappers.

The app does **almost nothing** — its entire job is to:
1. Bootstrap the SDK at `App.init` with TMDB credentials
2. Own the SwiftUI navigation (a TabView in this demo)
3. Drop one SDK screen into each tab via a hand-written 7-line `UIViewControllerRepresentable`

The SDK provides everything else: ViewModels, business logic, HTTP, and the actual UI that renders the data.

## What lives where

| Concern | Owner |
|---|---|
| TMDB API calls (Ktor + serialization) | **SDK** |
| ViewModels (`StateFlow<UiState<T>>`) | **SDK** |
| Compose Multiplatform UI for the 5 screens | **SDK** |
| Koin DI graph (registers HTTP/repo/VMs) | **SDK** (via `ImdbSdk.start(...)`) |
| TabView / NavigationStack | **Client** (`AppCoordinator.swift`) |
| `UIViewControllerRepresentable` wrappers (~7 LoC each) | **Client** (`Wrappers/SdkScreenRepresentables.swift`) |
| App bootstrap, credentials | **Client** |

## The entire navigation graph

```swift
TabView(selection: $selection) {
    HomeScreenRepresentable()      .tabItem { Label("Home",     systemImage: "house") }            .tag(0)
    MoviesScreenRepresentable()    .tabItem { Label("Movies",   systemImage: "film") }             .tag(1)
    TVShowsScreenRepresentable()   .tabItem { Label("TV",       systemImage: "tv") }               .tag(2)
    SearchScreenRepresentable()    .tabItem { Label("Search",   systemImage: "magnifyingglass") }  .tag(3)
    TrendingScreenRepresentable()  .tabItem { Label("Trending", systemImage: "flame") }            .tag(4)
}
```

Each `*Representable` is 7 lines that calls the corresponding SDK factory:

```swift
struct HomeScreenRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ViewControllerFactoriesKt.homeViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
```

## Why hand-written wrappers vs. KMP-ComposeUIViewController

The community plugin (GuilhE's `KMP-ComposeUIViewController`) auto-generates these wrappers from `@ComposeUIViewController` annotations. We chose to write them by hand because:

- The plugin's auto-export targets a sibling `iosApp/` directory in a monorepo. Our SDK and iOS client are in **separate repos**, so the auto-export path doesn't apply cleanly.
- Five screens × seven lines = 35 LoC, written once. Below the threshold where code-gen pays off.
- The wrappers are mechanical and only need editing when the SDK adds a new screen.

[**SKIE**](https://skie.touchlab.co) is enabled in the SDK, so the Kotlin↔Swift boundary is much cleaner than vanilla KMP — Kotlin `Flow` becomes Swift `AsyncSequence`, `suspend` becomes `async`, sealed classes become Swift `enum`s. The actual `viewController()` factory invocations are plain `ViewControllerFactoriesKt.<name>ViewController()`.

## Build & run

### One-time setup

1. **Build the SDK XCFramework** in a sibling clone of [composemultiplatformsdk](https://github.com/erikg84/composemultiplatformsdk):

   ```bash
   git clone https://github.com/erikg84/composemultiplatformsdk
   cd composemultiplatformsdk
   ./gradlew :imdb-sdk:assembleImdbSDKReleaseXCFramework
   ```

   The output lives at `imdb-sdk/build/XCFrameworks/release/ImdbSDK.xcframework`.

2. **Symlink (or copy) the framework** into this repo:

   ```bash
   cd /path/to/ComposeMultiplatformImdbDemo-iOS
   mkdir -p Frameworks
   ln -sfn /path/to/composemultiplatformsdk/imdb-sdk/build/XCFrameworks/release/ImdbSDK.xcframework Frameworks/ImdbSDK.xcframework
   ```

3. **Drop your TMDB credentials** into `ComposeMultiplatformImdbDemo/tmdb-token.txt` and `tmdb-api-key.txt` (both gitignored).

4. **Generate the Xcode project**:

   ```bash
   brew install xcodegen   # if you don't have it
   xcodegen generate
   open ComposeMultiplatformImdbDemo.xcodeproj
   ```

5. Build & run on a simulator (iOS 16+) from Xcode.

### Future cross-repo distribution

The current local-framework setup is dev-mode only. The production path is to mirror the [SwiftAndroidIMDBSdk](https://github.com/erikg84/SwiftAndroidIMDBSdk) pattern: the SDK release workflow zips the XCFramework, pushes it to GitHub Packages Maven, and updates a `composemultiplatformsdk-spm` wrapper repo's `Package.swift` `binaryTarget(url:checksum:)`. The iOS client then uses a single SPM dependency. This is documented as TODO in the SDK repo.

## License

MIT — see [LICENSE](LICENSE).
