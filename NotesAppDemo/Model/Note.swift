//
//  Note.swift
//  NotesAppDemo
//
//  Created by Thomas Lawless III on 1/10/24.
//

import Foundation
import SwiftData

@Model
class Note {
    var content: String
    var isFavorite: Bool = false
    var category: NoteCategory?
    
    init(content: String, category: NoteCategory? = nil){
        self.content = content
        self.category = category
    }
}
