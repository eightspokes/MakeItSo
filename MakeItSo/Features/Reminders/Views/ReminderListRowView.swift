//
//  ReminderListRowView.swift
//  MakeItSo
//
//  Created by Roman on 7/25/23.
//

import SwiftUI

struct ReminderListRowView: View {
    @Binding var reminder: Reminder
    
    var body: some View {
            HStack {
                Toggle(isOn: $reminder.isCompleted) {}
                    .toggleStyle(.reminder)
                Text(reminder.title)
                Spacer() //To ensure HStack consumes the entire available space
            }
            .contentShape(Rectangle())
    }
}

struct ReminderListRowView_Previews: PreviewProvider {
    struct Container: View {
    @State var reminder = Reminder.samples[2]
       var body: some View {
         ReminderListRowView(reminder: $reminder)
       }
     }
    
    static var previews: some View {
       Container()
    }
}
