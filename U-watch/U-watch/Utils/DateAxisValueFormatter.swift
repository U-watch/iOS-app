//
//  DateAxisFormatter.swift
//  U-watch
//
//  Created by 이승규 on 12/10/24.
//

import DGCharts

class DateAxisValueFormatter: IndexAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "HH:mm"
    }
    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
}
