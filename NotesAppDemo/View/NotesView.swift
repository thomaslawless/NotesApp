//
//  NotesView.swift
//  NotesAppDemo
//
//  Created by Thomas Lawless III on 1/10/24.
//

import SwiftUI
import SwiftData

struct NotesView: View {
    @Query private var notes: [Note]
    var category: String?
    var allCategories: [NoteCategory]
    init(category: String?, allCategories: [NoteCategory]) {
        self.category = category
        self.allCategories = allCategories
        //Dynamic filtering
        /**
         when set to all notes, it will fetch each note in the appp, when set to favorite, it will fetch only favorite notes... etc.....
         */
       /*
        let predicate = #Predicate<Note> {
            return $0.category?.categoryTitle == category
        }
        
        let favoritePredicate = #Predicate<Note> {
            return $0.isFavorite
        }
        
        let finalPredicate = category == "All notes" ? nil : (category  == "Favorites" ? favoritePredicate: predicate)
        
        _notes = Query(filter: finalPredicate, sort: [], animation: .snappy)
        */
    }
    //View Properties
    //@FocusState private var isKeyboardEnabled: Bool
    var body: some View {
        GeometryReader {
            let size = $0.size
            let width = size.width
            //Dynamic grid count based on the available size
            let rowCount = max(Int(width / 250), 1)
            
            ScrollView(.vertical){
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: rowCount), spacing: 10){
                    ForEach(notes) { note in
                        NoteCardView(note: note)
                        //NoteCardView(note: note, isKeyboardEnabled: $isKeyboardEnabled)
                    }
            }
                .padding(12)
            }
            //Closing TG when tapped outside
            .onTapGesture {
               // isKeyboardEnabled = false
            }
        }
    }
}

//Note card view
//with editable TF
struct NoteCardView: View {
    @Bindable var note: Note
   // var isKeyboardEnabled: FocusState<Bool>.Binding
    var body: some View {
        TextEditor(text: $note.content)
            .font(.body)
            .scrollContentBackground(.hidden)
            .multilineTextAlignment(.leading)
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.15), in: .rect(cornerRadius: 12))
    }
}

#Preview {
    ContentView()
}
