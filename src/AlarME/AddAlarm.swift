//
//  AddAlarm.swift
//  AlarME
//
//  Created by Runinterface on 25.10.2021.
//

import SwiftUI

struct AddAlarm: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var alarms: Alarm
    @State private var name = ""
    @State private var type = "Normal"
    @State private var time = ""
    @State private var date = ""
    
    let types = ["Normal", "QRCode"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Название", text: $name)
                Picker("Тип", selection: $type) {
                    ForEach(self.types, id: \.self){
                        Text($0)
                    }
                }
//                Picker("Тип", selection: $type) {
//                    ForEach(Self.types, id: \.self) {
//                        Text($0)
//                    }
//                }
                TextField("Время", text: $time)
                    .keyboardType(.numberPad)
                TextField("Дата", text: $date)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Добавить")
            .navigationBarItems(trailing: Button("Сохранить"){
                let item = AlarmItems(name: self.name, date: self.date, time: self.time, type: self.type)
                self.alarms.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        AddAlarm(alarms: Alarm)
        ContentView()
            .previewDevice("iPhone 12")
            
    }
}
}
