//
//  Note.swift
//  Notepad
//
//  Created by UdmurTio on 10.03.2021.
//

import RealmSwift

class Note: Object {
    @objc dynamic var theme: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var date: String = ""
    
    func saveData() {
        let saveObj = Note()
        
        saveObj.theme = "Default theme"
        saveObj.text = "Default text"
        saveObj.date = "Default date"
        
        DataManager.saveData(saveObj)
    }
}
