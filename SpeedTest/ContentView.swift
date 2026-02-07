import SwiftUI
import WidgetKit

struct ContentView: View {
    @State private var speedMbps: Double?
    @State private var isRunning = false
    @State private var progress: Double = 0
    @State private var errorMessage: String?
    @State private var lastResult: SpeedTestResult?

    var body: some View {
        VStack(spacing: 24) {
            Text("Speed Test")
                .font(.title.bold())

            speedGauge

            if let error = errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
            }

            if let result = lastResult {
                VStack(spacing: 4) {
                    Text("Last test: \(result.formattedTimestamp)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Button(action: runTest) {
                Label(isRunning ? "Testing..." : "Start Test", systemImage: isRunning ? "progress.indicator" : "bolt.fill")
                    .frame(minWidth: 140)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(isRunning)
        }
        .padding(40)
        .frame(minWidth: 320, minHeight: 300)
        .onAppear {
            lastResult = SharedDefaults.shared.loadResult()
            speedMbps = lastResult?.speedMbps
        }
    }

    @ViewBuilder
    private var speedGauge: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(.quaternary, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .rotationEffect(.degrees(135))

            if isRunning {
                Circle()
                    .trim(from: 0, to: progress * 0.75)
                    .stroke(.blue, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(135))
                    .animation(.easeOut(duration: 0.3), value: progress)
            }

            VStack(spacing: 4) {
                if let speed = speedMbps {
                    Text(formattedNumber(speed))
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .contentTransition(.numericText())

                    Text(speed >= 1000 ? "Gbps" : "Mbps")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                } else {
                    Text("--")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondary)

                    Text("Mbps")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(width: 200, height: 200)
    }

    private func formattedNumber(_ mbps: Double) -> String {
        if mbps >= 1000 {
            return String(format: "%.1f", mbps / 1000)
        } else if mbps >= 100 {
            return String(format: "%.0f", mbps)
        } else if mbps >= 10 {
            return String(format: "%.1f", mbps)
        } else {
            return String(format: "%.2f", mbps)
        }
    }

    private func runTest() {
        isRunning = true
        progress = 0
        errorMessage = nil

        Task {
            do {
                let result = try await SpeedTestService.shared.runSpeedTest { p in
                    Task { @MainActor in
                        progress = p
                    }
                }
                speedMbps = result.speedMbps
                lastResult = result
                WidgetCenter.shared.reloadTimelines(ofKind: "SpeedTestWidget")
            } catch {
                errorMessage = error.localizedDescription
            }
            isRunning = false
            progress = 0
        }
    }
}
