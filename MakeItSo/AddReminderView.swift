//
//  AddReminderView.swift
//  MakeItSo
//
//  Created by Roman on 7/23/23.
//

import SwiftUI

struct AddReminderView: View {
    
    enum FocusableField: Hashable {
      case title
    }


    @FocusState
    private var focusedField: FocusableField?

    @State private var reminder = Reminder(title: "")
    @Environment(\.dismiss)
    private var dismiss
    // Completion handler
    // This will require the View to receive a reminder  View{reminder in}
    var onCommitt: ( _ reminder: Reminder) -> Void
    
    private func commit(){
        onCommitt(reminder)
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("New Reminder", text: $reminder.title)
                    .focused($focusedField, equals: .title)
                    
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button{
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button(action: commit){
                        Text("Add Reminder")
                    }
                    .disabled(reminder.title.isEmpty)
                }
            }
            .onAppear{
                focusedField = .title
            }
            
        }
        
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView{
            reminder in
            print("Reminder \(reminder.title) added")
        }
    }
}
