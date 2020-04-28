//
//  PredictionView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/20/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Foundation

// uses RK Calendar from CalendarView
struct PredictionView : View {
    
    @State private var presented = true
    @State private var showDate = false
    @State private var showDay = false
    @State private var showWeek = false
    @State private var  colorOne: Color = Color.init(Color.RGBColorSpace.sRGB, red: 99.0 / 255, green: 0, blue: 49.0 / 255, opacity: 100);
    @State private var colorTwo: Color = Color.init(Color.RGBColorSpace.sRGB, red: 207.0 / 255, green: 69.0 / 255, blue: 32.0 / 255, opacity: 100)
    
    var manager = RKManager(calendar: Calendar.current, minimumDate: minPredictionDate, maximumDate: minPredictionDate.addingTimeInterval(60*60*24*365), mode: 0) // display year out from minPredictionDate
    
    var body: some View {
        VStack (spacing: 25) {
            HStack (alignment: .center){
                Button (action: {
                    self.showDay.toggle()
                }) {
                    Text("Average Day")
                }/* // alternative button style
                .frame(width:150, height:30)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [colorTwo, colorOne]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .padding(EdgeInsets(top: 0, leading: 20, bottom:0, trailing: 20))*/
                .buttonStyle(GradientButtonStyle())
                .sheet(isPresented: self.$showDay) {
                    AverageDayView()
                }
                
                Button (action: {
                    self.showWeek.toggle()
                }) {
                    Text("Average Week")
                }/* // alternative button style
                .frame(width:150, height:30)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [colorTwo, colorOne]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .padding(EdgeInsets(top: 0, leading: 20, bottom:0, trailing: 20))*/
                .buttonStyle(GradientButtonStyle())
                .sheet(isPresented: self.$showWeek) {
                    AverageWeekView()
                }
            }
            RKViewController(showDate: self.$showDate, rkManager: self.manager)
            .sheet(isPresented: self.$showDate, onDismiss: self.onDismiss) {
                PredictionDayView(date: self.manager.selectedDate)
            }
        }
    }
    
    func onDismiss() {
        self.manager.selectedDate = nil
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
    }
}

