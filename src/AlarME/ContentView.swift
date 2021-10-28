    //  ContentView.swift
    //  AlarME
    //
    //  Created by Runinterface on 22.10.2021.
    //

    import SwiftUI

    struct AlarmItems: Identifiable, Codable {
        var id = UUID()
        let name: String
        let dayRepeat: String
        let time: Date
        let type: String
        let status: Bool
    }
    
    struct QRItems: Identifiable, Codable {
        var id = UUID()
        let name: String
        let qrData: String
    }


    class QRCodes:ObservableObject {
        @Published var items = [QRItems]() {
            didSet {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(items) {
                    UserDefaults.standard.set(encoded, forKey: "Items")
                }
            }
        }
        init() {
            if let items = UserDefaults.standard.data(forKey: "Items") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([QRItems].self, from: items) {
                    self.items = decoded
                    return
                }
            }
        }
    }
    
    class Alarm: ObservableObject {
        @Published var items = [AlarmItems]() {
            didSet {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(items) {
                    UserDefaults.standard.set(encoded, forKey: "Items")
                }
            }
        }
        init() {
            if let items = UserDefaults.standard.data(forKey: "Items") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([AlarmItems].self, from: items) {
                    self.items = decoded
                    return
                }
            }
        }
    }
    
    struct ContentView: View {
        @State private var showingAddAlarm = false
        @ObservedObject var alarms = Alarm()
        @ObservedObject var qrcodes = QRCodes()
        @State var newDate = Date()
        let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
        
            func getDateTime(getData: Bool) -> String {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: newDate)
                let minutes = calendar.component(.minute, from: newDate)
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
        func removeItems(as offsets: IndexSet){
            alarms.items.remove(atOffsets: offsets)
        }
        
        
        
        var body: some View {
            VStack {
//                Text("\(getDateTime(getData: false))")
//                    .onReceive(timer, perform: { _ in
//                        self.newDate = Date()
//                    })
//    //                .position(x: 200, y: -330)
//                    .font(.title)
//                    .frame(maxHeight: 30)
//                Text("\(getDateTime(getData: true))")
//                    .onReceive(timer, perform: { _ in
//                        self.newDate = Date()
//                    })
//    //                .position(x: 200, y: -320)
//                    .font(.title3)
//                    .frame(maxHeight: 30)
                NavigationView {
                    List {
                        ForEach (alarms.items) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    Text(item.type)
                                        .font(.headline)
                                }
                                Spacer()
                                VStack {
                                    Text(item.dayRepeat)
                                    Text(item.dayRepeat)
                                        .font(.headline)
                                }
                            }

                        }
                        .onDelete(perform: removeItems)
                    }
                    .navigationTitle("Будильники")
                    .font(.title3)
                }
                Button(action: {
                    self.showingAddAlarm = true
                    
//                    self.alarms.items.append(Alarm)
                } ) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 30)
                        .sheet(isPresented: $showingAddAlarm) {
                            AddAlarm(alarms: self.alarms)
                        }
                }
            }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                
        }
    }
    }
    
