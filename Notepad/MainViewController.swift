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

    // MARK: - Table view data source

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
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }

}
