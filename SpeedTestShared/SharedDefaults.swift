import Foundation

final class SharedDefaults: Sendable {
    static let shared = SharedDefaults()

    nonisolated(unsafe) private let defaults: UserDefaults

    private init() {
        defaults = UserDefaults.standard
    }

    func saveResult(_ result: SpeedTestResult) {
        guard let data = try? JSONEncoder().encode(result) else { return }
        defaults.set(data, forKey: Constants.lastResultKey)
    }

    func loadResult() -> SpeedTestResult? {
        guard let data = defaults.data(forKey: Constants.lastResultKey) else { return nil }
        return try? JSONDecoder().decode(SpeedTestResult.self, from: data)
    }
}
