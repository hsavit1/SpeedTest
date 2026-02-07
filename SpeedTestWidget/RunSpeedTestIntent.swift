import AppIntents
import WidgetKit

struct RunSpeedTestIntent: AppIntent {
    static var title: LocalizedStringResource = "Run Speed Test"
    static var description = IntentDescription("Measures your download speed")

    func perform() async throws -> some IntentResult {
        _ = try await SpeedTestService.shared.runSpeedTest()
        WidgetCenter.shared.reloadTimelines(ofKind: "SpeedTestWidget")
        return .result()
    }
}
