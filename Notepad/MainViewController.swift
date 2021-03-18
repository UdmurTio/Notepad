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
        
        notes = realm.objects(Note.self)
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

    func edit(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, _) in
            let alert = UIAlertController(title: "Do you wand to edit", message: "grgege", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(alert, animated: true)
        }
        
        return action
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = self.edit(rowIndexPath: indexPath)
        let delete = self.delete(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipe
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let note = notes[indexPath.row]
//        let deleteDataAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
//            DataManager.deleteData(note)
//            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//        }
//
//        return [deleteDataAction]
//    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }

}
