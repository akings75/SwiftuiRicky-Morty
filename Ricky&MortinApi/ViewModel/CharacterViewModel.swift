//
//  CharacterViewModel.swift
//  Ricky&MortinApi
//
//  Created by Ahmet Akın Özbulut on 14.04.2023.
//

import Foundation

@MainActor
final class CharacterListViewModel : ObservableObject {
    
    @Published var characterList = [CharacterViewModel]()
    
    let webservice = Webservice()
    
    func downloadCharacter () async {
        
        do {
            let characters = try await webservice.download("https://rickandmortyapi.com/api/character/[1,2,3,4,5,6,7,8,9,10,11,12]")
            DispatchQueue.main.async {
                self.characterList = characters.map(CharacterViewModel.init)
            }
        } catch {
            print(error)
        }
    }
    
    
    
}
struct CharacterViewModel:Identifiable {
    
    let character : Character
    
    var id : Int {
        character.id
    }
    
    var name : String {
        character.name
    }
    
    var image : String {
        character.image
    }
    
    var gender : String {
        character.gender
    }
    
}
