//
//  HourlyStepChart.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 13.07.23.
//

import SwiftUI

struct HourlyStepsBarData {
    let value: Int?
}

private struct HourlyStepsClusterRenderingData {
    let title: String
    let renderingData: [HourlyStepsRenderingData]
}

private struct HourlyStepsRenderingData: Identifiable {
    let id = UUID()
    let valuePercent: CGFloat
    let opacity: CGFloat
}

struct HourlyStepsChartData {
    fileprivate let clusterData: [HourlyStepsClusterRenderingData]

    init(data: [HourlyStepsBarData]) {
        var data = data
        data.sanitizeSize()

        let maxValue = CGFloat(data.map({ $0.value ?? 0 }).max() ?? .max)
        let renderingData = data.map({ dataEntry -> HourlyStepsRenderingData in
            let value = CGFloat(dataEntry.value ?? 0)
            return HourlyStepsRenderingData(
                valuePercent: maxValue > 0 ? value / maxValue : 0.0,
                opacity: dataEntry.value != nil ? 1.0 : 0.3
            )
        })

        var clusterData = [HourlyStepsClusterRenderingData]()
        clusterData.append(HourlyStepsClusterRenderingData(
            title: "00",
            renderingData: Array(renderingData[0..<6])
        ))
        clusterData.append(HourlyStepsClusterRenderingData(
            title: "06",
            renderingData: Array(renderingData[6..<12])
        ))
        clusterData.append(HourlyStepsClusterRenderingData(
            title: "12",
            renderingData: Array(renderingData[12..<18])
        ))
        clusterData.append(HourlyStepsClusterRenderingData(
            title: "18",
            renderingData: Array(renderingData[18..<24])
        ))
        self.clusterData = clusterData
    }
}

struct HourlyStepsChart: View {
    let chartData: HourlyStepsChartData

    init(chartData: HourlyStepsChartData) {
        self.chartData = chartData
    }

    var body: some View {
        HStack(spacing: 0) {
            HourlyStepsClusterSpacer()
            HourlyStepsCluster(renderingData: chartData.clusterData[0])
            HourlyStepsClusterSpacer()
            HourlyStepsCluster(renderingData: chartData.clusterData[1])
            HourlyStepsClusterSpacer()
            HourlyStepsCluster(renderingData: chartData.clusterData[2])
            HourlyStepsClusterSpacer()
            HourlyStepsCluster(renderingData: chartData.clusterData[3])
            HourlyStepsClusterSpacer()
        }
    }
}

private struct HourlyStepsCluster: View {
    let renderingData: HourlyStepsClusterRenderingData

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack(spacing: 3) {
                    ForEach(renderingData.renderingData, content: {
                        HourlyStepsBar(renderingData: $0)
                    })
                }
                .padding([.leading, .trailing, .bottom], 2)
            }
            Text(renderingData.title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray.opacity(0.7))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

private struct HourlyStepsBar: View {
    let renderingData: HourlyStepsRenderingData

    var body: some View {
        GeometryReader { geometry in
            let height = max(geometry.size.height * renderingData.valuePercent, geometry.size.width)
            Rectangle()
                .fill(.accent.gradient)
                .opacity(renderingData.opacity)
                .cornerRadius(geometry.size.width / 2)
                .frame(width: geometry.size.width, height: height)
                .offset(y: geometry.size.height - height)
        }
    }
}

private struct HourlyStepsClusterSpacer: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(.gray.opacity(0.7))
                .frame(width: 1, height: geometry.size.height)
        }
        .frame(maxWidth: 1, maxHeight: .infinity, alignment: .bottom)
    }
}

private extension Array where Element == HourlyStepsBarData {
    mutating func sanitizeSize() {
        guard self.count < 24 else {
            self = Array(self[0..<24])
            return
        }
        let missingEntryCount = -(self.count - 24)
        let missingEntries = [HourlyStepsBarData](repeating: HourlyStepsBarData(value: nil), count: missingEntryCount)
        self.append(contentsOf: missingEntries)
    }
}

struct HourlyStepsChart_Previews: PreviewProvider {
    private static let previewData = [
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: nil),
        HourlyStepsBarData(value: 00),
        HourlyStepsBarData(value: 01),
        HourlyStepsBarData(value: 02),
        HourlyStepsBarData(value: 03),
        HourlyStepsBarData(value: 04),
        HourlyStepsBarData(value: 05),
        HourlyStepsBarData(value: 06),
        HourlyStepsBarData(value: 07),
        HourlyStepsBarData(value: 08),
        HourlyStepsBarData(value: 09),
        HourlyStepsBarData(value: 10),
        HourlyStepsBarData(value: 11),
        HourlyStepsBarData(value: 12)
    ]

    static var previews: some View {
        HourlyStepsChart(chartData: HourlyStepsChartData(
            data: Self.previewData
        ))
    }
}
