import Foundation

struct SpeedTestResult: Codable, Sendable {
    let speedMbps: Double
    let timestamp: Date
    let totalBytesDownloaded: Int

    var formattedSpeed: String {
        if speedMbps >= 1000 {
            return String(format: "%.1f Gbps", speedMbps / 1000)
        } else if speedMbps >= 100 {
            return String(format: "%.0f Mbps", speedMbps)
        } else if speedMbps >= 10 {
            return String(format: "%.1f Mbps", speedMbps)
        } else {
            return String(format: "%.2f Mbps", speedMbps)
        }
    }

    var formattedTimestamp: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
