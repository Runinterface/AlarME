    //  ContentView.swift
    //  AlarME
    //
    //  Created by Runinterface on 22.10.2021.
    //

    import SwiftUI

    struct AlarmItems: Identifiable, Codable {
        var id = UUID()
        let name: String
        let date: String
        let time: String
        let type: String
        
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
                Text("\(getDateTime(getData: false))")
                    .onReceive(timer, perform: { _ in
                        self.newDate = Date()
                    })
    //                .position(x: 200, y: -330)
                    .font(.title)
                    .frame(maxHeight: 30)
                Text("\(getDateTime(getData: true))")
                    .onReceive(timer, perform: { _ in
                        self.newDate = Date()
                    })
    //                .position(x: 200, y: -320)
                    .font(.title3)
                    .frame(maxHeight: 30)
                NavigationView {
                    List {
                        ForEach (alarms.items) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                VStack {
                                    Text(item.time)
                                        .font(.headline)
                                    Text(item.date)
                                }
                            }
//                            item in Text(item.name)
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
    
