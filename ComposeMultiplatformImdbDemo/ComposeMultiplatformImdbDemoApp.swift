import SwiftUI
import ImdbSDK

@main
struct ComposeMultiplatformImdbDemoApp: App {

    init() {
        // One-time SDK bootstrap. The SDK owns its own Koin DI graph,
        // its own Ktor HTTP client, its own ViewModels, and its own
        // Compose UI screens. We just hand it the credentials and
        // pick the platform engine (Darwin on iOS).
        ImdbSdk.shared.start(
            configuration: TmdbConfiguration(
                bearerToken: TokenLoader.bearerToken,
                apiKey: TokenLoader.apiKey,
                language: "en-US",
                baseUrl: "https://api.themoviedb.org/3",
                imageBaseUrl: "https://image.tmdb.org/t/p"
            ),
            platformHttpEngineFactory: { HttpClient() },
            appDeclaration: { _ in }
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
