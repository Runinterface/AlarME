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
    @State private var time = Date()
    @State private var dayRepeat = ""
    @State private var status = true
    
    let types = ["Normal", "QRCode"]
    let dayOfWeek = ["Понедельник", "Вторник", "Среда", "Чертверг", "Пятница", "Суббота", "Воскресенье"]
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Время", selection: $time, displayedComponents:
                            .hourAndMinute)
                    .labelsHidden()
//                    .padding(100)
                    .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                TextField("Название", text: $name)
                Picker("Тип", selection: $type) {
                    ForEach(self.types, id: \.self){
                        Text($0)
                    }
                }
                if (self.type == "QRCode") {
                    Picker("Выберите код", selection: $type) {
                        ForEach(self.types, id: \.self){
                            Text($0)
                        }
                    }
                }
//                Picker("Тип", selection: $type) {
//                    ForEach(Self.types, id: \.self) {
//                        Text($0)
//                    }
//                }
//                TextField("Время", text: $time)
//                    .keyboardType(.numberPad)

                Picker("Повтор", selection: $dayRepeat) {
                    ForEach(self.dayOfWeek, id: \.self){
                        Text($0)
                    }
                }
//                TextField("Повтор", text: $dayRepeat)
//                    .keyboardType(.numberPad)
            }
            .navigationTitle("Добавить")
            .navigationBarItems(trailing: Button("Сохранить"){
                let item = AlarmItems(name: self.name, dayRepeat: self.dayRepeat, time: self.time, type: self.type, status: self.status)
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
