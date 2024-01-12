//
//  NoteCategory.swift
//  NotesAppDemo
//
//  Created by Thomas Lawless III on 1/10/24.
//

import Foundation
import SwiftData

@Model
class NoteCategory{
    var categoryTitle: String
    //Relationship
    @Relationship(deleteRule: .cascade, inverse: \Note.category)
    var notes: [Note]?
    
    init(categoryTitle: String) {
        self.categoryTitle = categoryTitle
    }
}
