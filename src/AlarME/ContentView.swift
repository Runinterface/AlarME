//
//  ContentView.swift
//  AlarME
//
//  Created by Runinterface on 22.10.2021.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()


    func getDateTime(getData: Bool) -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        if minutes < 10 {
         let strMinutes = String(minutes)
         let newMinutes = ("0\(strMinutes)")
         var minutes = Int(newMinutes)
        } 
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "dd.MM.yyyy"
        let todaysDate = dateFormatt.string(from: date)
        if getData == true {
            return("\(todaysDate)")
        }
        else {
            return("\(hour):\(minutes)")
        }
    }
//    @State var newDate = Date()
//    @State var newTime = Date()
    
    var body: some View {
        var newTime = getDateTime(getData: false)
        var newDate = getDateTime(getData: true)
        VStack {
            Text("\(newTime)")
//                .position(x: 200, y: -330)
                .font(.title)
                .frame(maxHeight: 30)
            Text("\(newDate)")
//                .position(x: 200, y: -320)
                .font(.title3)
                .frame(maxHeight: 30)
            List {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
        }
//        .background(SwiftUI.Color.blue.edgesIgnoringSafeArea(.all))
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
            
    }
}
}
