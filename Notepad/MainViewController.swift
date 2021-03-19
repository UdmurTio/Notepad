//
//  MainViewController.swift
//  Notepad
//
//  Created by UdmurTio on 10.03.2021.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {

    var notes: Results<Note>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testForFirstLaunch()
        
        notes = realm.objects(Note.self)
        
        tableView.tableFooterView = UIView()
    }

    private func testForFirstLaunch() {
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            UserDefaults.standard.setValue(true, forKey: "isFirstLaunch")
            try! realm.write {
                realm.add(Note(theme: "Default", text: "Default", date: "Default"))
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.isEmpty ? 0 : notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.themeLabel.text = notes[indexPath.row].theme
        cell.dateLabel.text = notes[indexPath.row].date
        cell.mainTextLabel.text = notes[indexPath.row].text

        return cell
    }
    
    func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let self = self else {return}
            let note = self.notes[indexPath.row]
            DataManager.deleteData(note)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        
        return action
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToChangeNote" {
            guard let index = tableView.indexPathForSelectedRow else {return}
            let changedNote = notes[index.row]
            let editedNoteViewController = segue.destination as! NoteTableViewController
            editedNoteViewController.changedNote = changedNote
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }

}
