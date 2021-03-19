//
//  NewNoteTableViewController.swift
//  Notepad
//
//  Created by UdmurTio on 18.03.2021.
//

import UIKit

class NoteTableViewController: UITableViewController, UITextFieldDelegate {

    var changedNote: Note?
    @IBOutlet weak var theme: UITextField!
    @IBOutlet weak var mainText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tmpNote = changedNote {
            changeNotePrepare(forNote: tmpNote)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
    
    private func changeNotePrepare(forNote changedNote: Note) {
        theme.text = changedNote.theme
        mainText.text = changedNote.text
        
        navigationItem.leftBarButtonItem = nil
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        self.saveNewNote()
        performSegue(withIdentifier: "UnwindToMain", sender: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func saveNewNote() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let now = df.string(from: Date())
        
        let newNote = Note(theme: theme.text!, text: mainText.text!, date: now)
        
        if let didChangedNote = changedNote {
            try! realm.write {
                didChangedNote.theme = newNote.theme
                didChangedNote.date = newNote.date
                didChangedNote.text = newNote.text
            }
        } else {
            DataManager.saveData(newNote)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    }

}
