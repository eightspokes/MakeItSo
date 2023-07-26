//
//  AddReminderView.swift
//  MakeItSo
//
//  Created by Roman on 7/23/23.
//

import SwiftUI

struct EditReminderDetailsView: View {
    
    enum FocusableField: Hashable {
      case title
    }


    @FocusState
    private var focusedField: FocusableField?
    
    enum Mode {
        case add
        case edit
    }
    var mode: Mode = .add
    
    @State var reminder = Reminder(title: "")
    
    
    
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
                    .onSubmit {
                        commit()
                    }
                    
            }
            .navigationTitle(mode == .add ? "New Reminder" : "Details")
            .navigationBarTitleDisplayMode(.inline)
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
    struct Container: View {
       @State var reminder = Reminder.samples[0]
       var body: some View {
         EditReminderDetailsView(mode: .edit, reminder: reminder) { reminder in
           print("You edited a reminder: \(reminder.title)")
         }
       }
     }
    
    
    static var previews: some View {
        EditReminderDetailsView { reminder in
              print("You added a reminder: \(reminder.title)")
            }
        Container()
    }
}
