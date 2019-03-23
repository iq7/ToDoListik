//
//  note.swift
//  ToDoListik
//
//  Created by Андрей Тихонов on 22/03/2019.
//  Copyright © 2019 Андрей Тихонов. All rights reserved.
//

import Foundation

protocol NoteProtocol: class {
    var title: String { get set }
    func getCount() -> Int
}

class Note: NoteProtocol {
    var title: String
    
    var notes: [Note] = []
    func getCount() -> Int {
        return self.notes.count
    }
    
    init(title: String) {
        self.title = title
    }
}
