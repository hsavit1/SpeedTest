import Foundation

enum Constants {
    static let appGroupID = "group.com.speedtest.shared"
    static let lastResultKey = "lastSpeedTestResult"

    static let cloudflareBaseURL = "https://speed.cloudflare.com/__down"

    static let warmupBytes = 50_000
    static let chunkSizes = [100_000, 1_000_000, 5_000_000, 10_000_000, 25_000_000]
    static let maxTestDuration: TimeInterval = 15.0
    static let skipLargeChunkThreshold: Double = 50.0 // Mbps
}
