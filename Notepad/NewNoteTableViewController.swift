//
//  NewNoteTableViewController.swift
//  Notepad
//
//  Created by UdmurTio on 18.03.2021.
//

import UIKit

class NewNoteTableViewController: UITableViewController {


    @IBOutlet weak var theme: UITextField!
    @IBOutlet weak var mainText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
        self.saveNewNote()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    // MARK: - Table view data source

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
        
        DataManager.saveData(newNote)
    }

}
