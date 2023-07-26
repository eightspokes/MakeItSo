//
//   RemindersRepository.swift
//  MakeItSo
//
//  Created by Roman on 7/25/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RemindersRepository : ObservableObject {
   @Published var reminders = [Reminder]()
    init() {
      subscribe()
    }


    deinit {
      unsubscribe()
    }
    private var listenerRegistration: ListenerRegistration?
    //a snapshot listener
    
    
    
    func subscribe(){
        if listenerRegistration == nil {
            let query = Firestore.firestore().collection(Reminder.collectionName)
            listenerRegistration = query
                .addSnapshotListener { [weak self] (querySnapshot, error) in
                    
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }
                    print("Mapping \(documents.count) documents")
                    self?.reminders = documents.compactMap { queryDocumentSnapshot in
                        do {
                            return try queryDocumentSnapshot.data(as: Reminder.self)
                        }
                        catch {
                            print("Error while trying to map document \(queryDocumentSnapshot.documentID): \(error.localizedDescription)")
                            return nil
                        }
                    }
                }
        }
    }
    private func unsubscribe() {
      if listenerRegistration != nil {
        listenerRegistration?.remove()
        listenerRegistration = nil
      }
    }
    
    
    func addReminder(_ reminder: Reminder) throws {
        do {
            try Firestore
                .firestore()
                .collection(Reminder.collectionName) // path where all reminders will be stored.
                .addDocument(from: reminder)
            print("*****Reminder added ")
        } catch let error {
            // Handle the error here
            print("*****Error adding reminder: \(error)")
            throw error // rethrow the error to be handled by the caller if needed
        }
    }
    
    func updateReminder(_ reminder: Reminder) throws {
        
        guard let documentId = reminder.id else {
              fatalError("Reminder \(reminder.title) has no document ID.")
            }
        /*
         By using merge: true, you make sure that Firestore doesn’t overwrite the existing document with the values of reminder.
         */
        try Firestore
              .firestore()
              .collection(Reminder.collectionName)
              .document(documentId)
              .setData(from: reminder, merge: true)
    }
    func removeReminder(_ reminder: Reminder){
        guard let documentId = reminder.id else {
            fatalError("Reminder \(reminder.title) has no document ID.")
        }
        Firestore
            .firestore()
            .collection(Reminder.collectionName)
            .document(documentId)
            .delete()
    }
    
}
