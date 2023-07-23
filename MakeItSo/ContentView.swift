//
//  ContentView.swift
//  MakeItSo
//
//  Created by Roman on 7/23/23.
//

import SwiftUI

struct ContentView: View {
    @State private var reminders = Reminder.samples
    @State private var isAddReminderDialogPresented = false
    private func presentAddReminderView() {
      isAddReminderDialogPresented.toggle()
    }

    var body: some View {
        VStack {
            List() {
              Section {
                ForEach($reminders, id: \.self) { $reminder in
                    HStack {
                        Image(systemName: reminder.isCompleted
                                      ? "largecircle.fill.circle"
                                      : "circle")
                                  .imageScale(.large)
                                  .foregroundColor(.accentColor)
                                  .onTapGesture {
                                      reminder.isCompleted.toggle()
                                  }
                        Text(reminder.title)
                    }
                }
              } header: {
                 
                      
                      Text("Reminders")
                      
                  
                
              } footer: {
                Text("\(reminders.count) reminders")
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
                AddReminderView{ reminder in
                    reminders.append(reminder)
                    
                }
            }
          
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationStack {
            ContentView()
        }
    }
}
