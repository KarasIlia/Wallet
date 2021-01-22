//
//  ViewController + Charts.swift
//  Wallet
//
//  Created by Илья Карась on 17.11.2020.
//

import Foundation
import Charts

extension ViewController {
  
  func setupChartLayout() {
    chartView.xAxis.drawGridLinesEnabled = false
    chartView.xAxis.labelPosition = .bottom
    chartView.xAxis.drawAxisLineEnabled = false

    chartView.leftAxis.drawGridLinesEnabled = false
    chartView.leftAxis.enabled = false

    chartView.rightAxis.drawGridLinesEnabled = false
    chartView.rightAxis.enabled = false
    
    chartView.legend.enabled = false
    chartView.pinchZoomEnabled = false
  }

  func updateGraph() {
    var lineChartEntries = [ChartDataEntry]()
    
    for x in 0...10 {
      let value = ChartDataEntry(x: Double(x), y: Double(arc4random_uniform(100)))
      lineChartEntries.append(value)
    }
    
    let lineDataSet = LineChartDataSet(entries: lineChartEntries)
    lineDataSet.colors = [UIColor(displayP3Red: 91.0 / 255.0, green: 201.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)]
    lineDataSet.drawValuesEnabled = false
    lineDataSet.drawCirclesEnabled = false
    lineDataSet.drawFilledEnabled = true

    lineDataSet.mode = .cubicBezier
    lineDataSet.lineWidth = 3

    let gradientColors = [lineDataSet.colors[0].cgColor, UIColor.white.cgColor]
    let colorLocations: [CGFloat] = [1.0, 0.0]
    if let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: colorLocations) {
      lineDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
    }
    
    let data = LineChartData()
    data.addDataSet(lineDataSet)

    chartView.data = data
  }
}
