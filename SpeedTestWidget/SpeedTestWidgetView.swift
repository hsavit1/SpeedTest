import SwiftUI
import WidgetKit

struct SpeedTestWidgetView: View {
    let entry: SpeedTestEntry

    var body: some View {
        VStack(spacing: 8) {
            if let result = entry.result {
                speedDisplay(result)
            } else {
                noResultView
            }

            Button(intent: RunSpeedTestIntent()) {
                Label("Test Speed", systemImage: "bolt.fill")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }

    private func speedDisplay(_ result: SpeedTestResult) -> some View {
        VStack(spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(speedNumber(result.speedMbps))
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .contentTransition(.numericText())

                Text(speedUnit(result.speedMbps))
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }

            Text(result.formattedTimestamp)
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
    }

    private var noResultView: some View {
        VStack(spacing: 4) {
            Image(systemName: "gauge.with.dots.needle.33percent")
                .font(.system(size: 28))
                .foregroundStyle(.secondary)

            Text("No test yet")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func speedNumber(_ mbps: Double) -> String {
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

    private func speedUnit(_ mbps: Double) -> String {
        mbps >= 1000 ? "Gbps" : "Mbps"
    }
}
