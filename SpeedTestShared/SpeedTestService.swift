import Foundation

actor SpeedTestService {
    static let shared = SpeedTestService()

    private var isRunning = false

    struct SpeedSample {
        let bytes: Int
        let duration: TimeInterval

        var mbps: Double {
            let bits = Double(bytes) * 8
            let megabits = bits / 1_000_000
            return megabits / duration
        }
    }

    func runSpeedTest(onProgress: (@Sendable (Double) -> Void)? = nil) async throws -> SpeedTestResult {
        guard !isRunning else {
            throw SpeedTestError.alreadyRunning
        }
        isRunning = true
        defer { isRunning = false }

        let session = URLSession(configuration: .ephemeral)
        defer { session.invalidateAndCancel() }

        // Warm-up: download small chunk to establish connection
        let warmupURL = URL(string: "\(Constants.cloudflareBaseURL)?bytes=\(Constants.warmupBytes)")!
        let _ = try await session.data(from: warmupURL)

        var samples: [SpeedSample] = []
        let testStart = Date()
        var totalBytes = 0

        for (index, chunkSize) in Constants.chunkSizes.enumerated() {
            // Check if we've exceeded max test duration
            if Date().timeIntervalSince(testStart) > Constants.maxTestDuration {
                break
            }

            // Skip 25MB chunk if speed is below threshold
            if chunkSize == 25_000_000, !samples.isEmpty {
                let currentSpeed = weightedAverageSpeed(samples)
                if currentSpeed < Constants.skipLargeChunkThreshold {
                    break
                }
            }

            let url = URL(string: "\(Constants.cloudflareBaseURL)?bytes=\(chunkSize)")!
            let start = CFAbsoluteTimeGetCurrent()
            let (data, _) = try await session.data(from: url)
            let elapsed = CFAbsoluteTimeGetCurrent() - start

            let sample = SpeedSample(bytes: data.count, duration: elapsed)
            samples.append(sample)
            totalBytes += data.count

            let progress = Double(index + 1) / Double(Constants.chunkSizes.count)
            onProgress?(progress)
        }

        guard !samples.isEmpty else {
            throw SpeedTestError.noSamples
        }

        let speed = weightedAverageSpeed(samples)

        let result = SpeedTestResult(
            speedMbps: speed,
            timestamp: Date(),
            totalBytesDownloaded: totalBytes
        )

        SharedDefaults.shared.saveResult(result)

        return result
    }

    private func weightedAverageSpeed(_ samples: [SpeedSample]) -> Double {
        let totalWeight = samples.reduce(0.0) { $0 + Double($1.bytes) }
        guard totalWeight > 0 else { return 0 }
        let weightedSum = samples.reduce(0.0) { $0 + $1.mbps * Double($1.bytes) }
        return weightedSum / totalWeight
    }
}

enum SpeedTestError: LocalizedError {
    case alreadyRunning
    case noSamples

    var errorDescription: String? {
        switch self {
        case .alreadyRunning: return "A speed test is already running"
        case .noSamples: return "No speed samples collected"
        }
    }
}
