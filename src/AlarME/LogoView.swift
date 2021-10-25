//
//  LogoView.swift
//  AlarME
//
//  Created by Runinterface on 25.10.2021.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack {
            Image("sc_logo")
                .resizable()
                .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
