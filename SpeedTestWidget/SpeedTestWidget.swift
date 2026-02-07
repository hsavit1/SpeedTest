import WidgetKit
import SwiftUI

struct SpeedTestWidgetConfig: Widget {
    let kind = "SpeedTestWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SpeedTestTimelineProvider()) { entry in
            SpeedTestWidgetView(entry: entry)
        }
        .configurationDisplayName("Speed Test")
        .description("Test your download speed with one tap.")
        .supportedFamilies([.systemSmall])
    }
}

@main
struct SpeedTestWidgetBundle: WidgetBundle {
    var body: some Widget {
        SpeedTestWidgetConfig()
    }
}
