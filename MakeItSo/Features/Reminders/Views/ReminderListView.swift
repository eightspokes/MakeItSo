//
//  ContentView.swift
//  MakeItSo
//
//  Created by Roman on 7/23/23.
//

import SwiftUI

struct ReminderListView: View {
    @StateObject var viewModel = RemindersListViewModel()
    
    @State private var isAddReminderDialogPresented = false
    
    @State private var editableReminder: Reminder? = nil
    
    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }
    
    var body: some View {
        NavigationStack {
          
            List($viewModel.reminders) { $reminder in
                
                ReminderListRowView(reminder: $reminder)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive, action: {viewModel.deleteReminder(reminder)}) {
                            Image(systemName: "trash")

                        }
                        .tint(Color(UIColor.systemRed))
                    }
                    .onChange(of: reminder.isCompleted) { newValue in
                        viewModel.setCompleted(reminder, isCompleted: newValue)
                    }
                    .onTapGesture {
                        editableReminder = reminder
                    }
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: presentAddReminderView) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $isAddReminderDialogPresented){
                EditReminderDetailsView{ reminder in
                    viewModel.addReminder(reminder)
                    
                }
            }
            .sheet(item: $editableReminder) { reminder in
                EditReminderDetailsView(mode: .edit, reminder: reminder) { reminder in
                    viewModel.updateReminder(reminder)
                }
            }
            .tint(.red)
            .navigationTitle("Reminders")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReminderListView()
        }
    }
}

