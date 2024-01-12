//
//  NotesAppDemoApp.swift
//  NotesAppDemo
//
//  Created by Thomas Lawless III on 1/10/24.
//

import SwiftUI
import SwiftData

@main
struct NotesAppDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 320, minHeight: 400)
        }
        .windowResizability(.contentSize)
        
        //Adding Data Model to the App
        .modelContainer(for: [Note.self, NoteCategory.self])
    }
}
