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
    
    convenience init(theme: String, text: String, date: String) {
        self.init()
        self.theme = theme
        self.text = text
        self.date = date
    }
}
