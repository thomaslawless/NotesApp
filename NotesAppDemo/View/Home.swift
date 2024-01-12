//
//  Home.swift
//  NotesAppDemo
//
//  Created by Thomas Lawless III on 1/10/24.
//

import SwiftUI
import SwiftData
struct Home: View {
    //List selection - use as a tab filer to the seelcted category
    @State private var selectedTag: String? = "All Notes"
    //Quering all categories
    @Query(animation: .snappy) private var categories: [NoteCategory]
    //Model Context
    @Environment(\.modelContext) private var context
    //View properties
    @State private var addCategory: Bool = false
    @State private var categoryTitle: String = ""
    @State private var noteTitle: String = ""
    @State private var requestedCateegory: NoteCategory?
    @State private var deleteRequest: Bool = false
    @State private var renameRequest: Bool = false
    //dark mode toggle
    @State private var isDark: Bool = true
    var body: some View {
        NavigationSplitView{
            List(selection: $selectedTag) {
                Text("All Notes")
                    .tag("All Notes")
                    .foregroundStyle(selectedTag == "All Notes" ? Color.primary : .gray)
                
                Text("Favorites")
                    .tag("Favorites")
                    .foregroundStyle(selectedTag == "Favorites" ? Color.primary : .gray)
                
                Section {
                    ForEach(categories) { category in
                        Text(category.categoryTitle)
                            .tag(category.categoryTitle)
                            .foregroundStyle(selectedTag == category.categoryTitle ? Color.primary: .gray)
                            .contextMenu{
                                Button("Rename"){
                                    //placing the already having title in the textfield
                                    categoryTitle = category.categoryTitle
                                    requestedCateegory = category
                                    renameRequest = true
                                }
                                Button("Delete"){
                                    categoryTitle = category.categoryTitle
                                    requestedCateegory = category
                                    deleteRequest = true
                                    
                                }
                            }
                    }
                    
                }header: {
                    HStack(spacing: 5){
                        Text("Categories")
                        
                        Button("", systemImage: "plus"){
                            addCategory.toggle()
                            
                        }
                        .tint(.gray)
                        .buttonStyle(.plain)
                    }
                }
            }
        } detail: {
            //Notes view with Dyanmic filtering based on the category
            NotesView(category: selectedTag, allCategories: categories)
        }
        .navigationTitle(selectedTag ?? "Notes")
        // adding category alert
        .alert("Add Category", isPresented: $addCategory){
            
            TextField("Category", text: $categoryTitle)
            Button("Cancel", role: .cancel){
                categoryTitle = ""
            }
            Button("Add"){
                //Adding new Category to Swift Data
                let category = NoteCategory(categoryTitle: categoryTitle)
                context.insert(category)
                print ("cat add button")
                categoryTitle = ""
            }
        }
        //Rename alert
        .alert("Rename Category", isPresented: $renameRequest){
            TextField("Work", text: $categoryTitle)
            
            Button("Cancel", role: .cancel){
                categoryTitle = ""
                requestedCateegory = nil
            }
            
            Button("Rename"){
                if let requestedCateegory {
                    requestedCateegory.categoryTitle = categoryTitle
                    categoryTitle = ""
                    self.requestedCateegory = nil
                }
            }
        }
        //Delete
        .alert("Are you sure you want to delete \(categoryTitle)", isPresented: $deleteRequest){
            Button("Cancel", role: .cancel){
                categoryTitle = ""
                requestedCateegory = nil
            }
            
            Button("Delete", role: .destructive){
                if let requestedCateegory {
                    context.delete(requestedCateegory)
                    categoryTitle = ""
                    self.requestedCateegory = nil
                }
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .primaryAction){
                HStack(spacing: 10){
                    Button("", systemImage: "plus"){
                        print("note button pressed")
                        //Adding new note
                        let note = Note(content: noteTitle)
                        context.insert(note)
                    }
                    Button("", systemImage: isDark ? "sun.min" : "moon"){
                        isDark.toggle()
                    }
                    .contentTransition(.symbolEffect(.replace))
                }
            }
        }
        .preferredColorScheme(isDark ? .dark : .light
        )
    }
    }

#Preview {
    ContentView()
}
