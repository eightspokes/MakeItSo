//
//  Reminder.swift
//  MakeItSo
//
//  Created by Roman on 7/23/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Reminder: Identifiable, Codable {
    @DocumentID var id: String? // The @DocumentID property wrapper requires a String type
    var title: String
    var isCompleted = false
    
    mutating func toggleIsCompteted(){
        isCompleted.toggle()
    }
}
extension Reminder {
  static let collectionName = "reminders"
}

extension Reminder {
    static let samples = [
    Reminder(title: "Create tutorial", isCompleted: false),
    Reminder(title: "Build this app", isCompleted: true),
    Reminder(title: "???"),
    Reminder(title: "Profit!"),
    Reminder(title: "Create tutorial2", isCompleted: false)
    ]
}
