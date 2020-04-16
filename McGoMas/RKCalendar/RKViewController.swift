import SwiftUI

struct RKViewController: View {
    @Binding var showDate: Bool
    @ObservedObject var rkManager: RKManager
    
    var body: some View {
        Group {
            RKWeekdayHeader(rkManager: self.rkManager)
            Divider()
            List {
                ForEach(0..<numberOfMonths()) { index in
                    RKMonth(showDate: self.$showDate, rkManager: self.rkManager, monthOffset: index)
                }
                Divider()
            }
        }
    }
    
    func numberOfMonths() -> Int {
        return rkManager.calendar.dateComponents([.month], from: rkManager.minimumDate, to: RKMaximumDateMonthLastDay()).month! + 1
    }
    
    func RKMaximumDateMonthLastDay() -> Date {
        var components = rkManager.calendar.dateComponents([.year, .month, .day], from: rkManager.maximumDate)
        components.month! += 1
        components.day = 0
        
        return rkManager.calendar.date(from: components)!
    }
}
