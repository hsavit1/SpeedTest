import WidgetKit

struct SpeedTestEntry: TimelineEntry {
    let date: Date
    let result: SpeedTestResult?
    let isPlaceholder: Bool

    init(date: Date = Date(), result: SpeedTestResult? = nil, isPlaceholder: Bool = false) {
        self.date = date
        self.result = result
        self.isPlaceholder = isPlaceholder
    }
}

struct SpeedTestTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> SpeedTestEntry {
        SpeedTestEntry(result: SpeedTestResult(speedMbps: 100, timestamp: Date(), totalBytesDownloaded: 0), isPlaceholder: true)
    }

    func getSnapshot(in context: Context, completion: @escaping (SpeedTestEntry) -> Void) {
        let result = SharedDefaults.shared.loadResult()
        completion(SpeedTestEntry(result: result))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SpeedTestEntry>) -> Void) {
        let result = SharedDefaults.shared.loadResult()
        let entry = SpeedTestEntry(result: result)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}
