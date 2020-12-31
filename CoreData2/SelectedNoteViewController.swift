//
//  SelectedNoteViewController.swift
//  CoreData2
//
//  Created by Field Employee on 12/30/20.
//

import UIKit

class SelectedNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var okButton: UIButton!
    
    
    var note : Note!
    var delegate : NoteCreationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.alpha = 0
        
       
        
        titleTF.text = note.title
        contentTextView.text = note?.content
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 1) {
            self.okButton.alpha = 1
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 1) {
            self.okButton.alpha = 0
        }
        
    }
    @IBAction func textFieldDone(_ sender: Any) {
    }
    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        note?.title = titleTF.text
        note?.content = contentTextView.text
        if note?.content != nil, note?.title != nil {
            delegate?.noteReturned(note: note, sender: self)
            dismiss(animated: true, completion: nil)
        }
    }
}
