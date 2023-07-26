//
//  RemindersListViewModel.swift
//  MakeItSo
//
//  Created by Roman on 7/25/23.
//

import Foundation
import Combine
class RemindersListViewModel: ObservableObject {
    
    //Views will be updated when reminders change (because of published property)
    @Published var reminders = [Reminder]()
    @Published var errorMessage: String?
    private var remindersRepository: RemindersRepository =  RemindersRepository()
    
    /*
    Use Combine’s assign operator to keep the local reminders property in sync with the reminders property on RemindersRepository.
    */
    init() {
        remindersRepository
          .$reminders
          .assign(to: &$reminders)
      }
    
    func addReminder(_ reminder: Reminder){
        do{
            try remindersRepository.addReminder(reminder)
            errorMessage = nil
        }catch{
            errorMessage = error.localizedDescription
            print(errorMessage as Any)
        }
        
    }
    func updateReminder(_ reminder: Reminder) {
        do {
          try remindersRepository.updateReminder(reminder)
        }
        catch {
          print(error)
          errorMessage = error.localizedDescription
        }
      }
    
    
    
    func setCompleted(_ reminder: Reminder, isCompleted: Bool) {
        var editedReminder = reminder
        editedReminder.isCompleted = isCompleted
        updateReminder(editedReminder)
    }
    func deleteReminder(_ reminder: Reminder) {
        remindersRepository.removeReminder(reminder)
    }
}
