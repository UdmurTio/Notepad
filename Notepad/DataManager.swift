//
//  DataManager.swift
//  Notepad
//
//  Created by UdmurTio on 10.03.2021.
//

import RealmSwift

let realm = try! Realm()

class DataManager {
    static func saveData(_ newNote: Note) {
        try! realm.write {
            realm.add(newNote)
        }
    }
    
    static func deleteData(_ deletedNote: Note) {
        try! realm.write {
            realm.delete(deletedNote)
        }
    }
}
