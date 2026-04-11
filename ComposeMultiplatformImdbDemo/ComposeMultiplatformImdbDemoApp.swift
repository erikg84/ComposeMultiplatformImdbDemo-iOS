import SwiftUI
import ImdbSDK

@main
struct ComposeMultiplatformImdbDemoApp: App {

    init() {
        // One-time SDK bootstrap. The SDK owns its own Koin DI graph,
        // its own Ktor HTTP client (Darwin engine on iOS by default —
        // Ktor 3 auto-detects since the SDK ships ktor-client-darwin),
        // its own ViewModels, and its own Compose UI screens.
        // SKIE bridges the Kotlin default parameters so we can omit
        // platformHttpEngineFactory and appDeclaration here.
        ImdbSdk.shared.start(
            configuration: TmdbConfiguration(
                bearerToken: TokenLoader.bearerToken,
                apiKey: TokenLoader.apiKey
            )
        )
    }

    var body: some Scene {
        WindowGroup {
            AppCoordinator()
        }
    }
}

/// Loads TMDB credentials from gitignored bundle resources.
enum TokenLoader {
    static var bearerToken: String { read("tmdb-token") }
    static var apiKey: String { read("tmdb-api-key") }

    private static func read(_ name: String) -> String {
        if let url = Bundle.main.url(forResource: name, withExtension: "txt"),
           let s = try? String(contentsOf: url, encoding: .utf8) {
            return s.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return ""
    }
}
