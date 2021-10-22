//
//  DateTime.swift
//  AlarME
//
//  Created by Runinterface on 22.10.2021.
//

import Foundation


let date = Date()
let calendar = Calendar.current
let hour = calendar.component(.hour, from: date)
let minutes = calendar.component(.minute, from: date)


