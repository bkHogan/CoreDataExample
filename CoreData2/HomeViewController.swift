//
//  ViewController.swift
//  CoreData2
//
//  Created by Field Employee on 12/30/20.
//

import UIKit
import CoreData

struct NoteObject {
    var id: UUID!
    var title: String?
    var content: String?
    var createdDate: Date?
    
    init(id: UUID){
        self.id = id
        self.createdDate = Date()
    }
    
    init(id: UUID, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
        self.createdDate = Date()
    }
}

protocol NoteCreationDelegate {
    func noteReturned(note : Note?, sender: UIViewController)
    
}

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NoteCreationDelegate{

    

    @IBOutlet weak var addNewNoteButton: UIButton!
    @IBOutlet weak var notesTV: UITableView!
    
    var notes :[Note] = [Note]()
    var selectedNote : Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        notesTV.reloadData()
    }
    
    private func readCoreData() {
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        
        do{
            let notes = try AppDelegate.viewContext.fetch(request)
        } catch {
            print("Error getting notes")
        }

    }
    

    //MARK: - Target Actions
    @IBAction func addNewButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "show note", sender: self)
    }
    
    //MARK: - TableView Stuff
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell
        
        cell.celTopLabel.text = notes[indexPath.row].title
        cell.cellContentLabel.text = notes[indexPath.row].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notes[indexPath.row]
        performSegue(withIdentifier: "show note", sender: self)
    }
    
   
    //MARK: - Delegate Calls
    func noteReturned(note: Note?, sender: UIViewController) {
        
        
        if let note = note {
            
            if let index = notes.firstIndex(where: { one in one.id == note.id
            }) {
                self.notes[index] = note
                notesTV.reloadRows(at: [IndexPath(row: index, section: 0)], with: .left)
            } else {
                notes.append(note)
                notesTV.insertRows(at: [IndexPath(row: notes.count-1, section: 0)], with: .automatic)
            }
    }
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show note", let destination = segue.destination as? SelectedNoteViewController {
            destination.note = selectedNote
            selectedNote = nil
            destination.delegate = self
        }
    }
    
}

