//
//  Reminder.swift
//  MakeItSo
//
//  Created by Roman on 7/23/23.
//

import Foundation

struct Reminder: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var isCompleted = false
}

extension Reminder {
    static let samples = [
    Reminder(title: "Bildd this app", isCompleted: true),
    Reminder(title: "Create tutorial"),
    Reminder(title: "???"),
    Reminder(title: "Profit!")
    ]
}
