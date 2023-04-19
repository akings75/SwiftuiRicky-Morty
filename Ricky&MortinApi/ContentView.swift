//
//  ContentView.swift
//  Ricky&MortinApi
//
//  Created by Ahmet Akın Özbulut on 14.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var characterListViewModel = CharacterListViewModel()
    @State private var filtered: [CharacterViewModel] = []
    @State private var query = ""
    
    func search(with query: String) {
        filtered = characterListViewModel.characterList.filter {
            $0.name.contains(query)
        }
    }
    
    private var characters: [CharacterViewModel] {
        filtered.isEmpty ? characterListViewModel.characterList : filtered
        
    }
    /*
    init() {
        self.characterListViewModel = CharacterListViewModel()
    }
     */
    var body: some View {
        NavigationStack {
            List(characters) { character in
                HStack (spacing:10){
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.image?.resizable().scaledToFit().frame(width:100, height: 100)
                        
                    }
                    VStack(spacing:10) {
                    
                        Text(character.name).font(.title3).foregroundColor(.blue)
                        Text(character.gender)
                    }
                    
                }
            }
        }.searchable(text: $query,prompt: "Ara")
            .onChange(of: query,perform: search)
             
         .task {
             await characterListViewModel.downloadCharacter()
            }
               
        }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
