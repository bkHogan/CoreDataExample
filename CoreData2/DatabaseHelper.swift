//
//  DatabaseHelper.swift
//  CoreData2
//
//  Created by Field Employee on 12/31/20.
//

import Foundation
import CoreData

class CDNote : NSManagedObject {
    
    class func createOrUpdate(id: UUID, title: String, content: String) -> Note {
        print("create or update note")
        
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let notes = try AppDelegate.viewContext.fetch(request)
            
            if notes.count > 0 {
                assert(notes.count == 1, "more than one with same title")
                notes[0].content = content
                
                DispatchQueue.main.async {
                    try? AppDelegate.viewContext.save()
                }
                return notes[0]
                                
            }
            
        } catch {
            print("Error getting notes")
        }
        
        let note = Note(context: AppDelegate.viewContext)
        
        note.id = id
        note.title = title
        note.content = content
        note.createdDate = Date()
        
        DispatchQueue.main.async {
            try? AppDelegate.viewContext.save()
        }
        
        return note
    }
}
