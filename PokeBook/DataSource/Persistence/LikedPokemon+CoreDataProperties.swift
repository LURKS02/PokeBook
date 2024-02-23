//
//  LikedPokemon+CoreDataProperties.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/24.
//
//

import Foundation
import CoreData

extension LikedPokemon {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedPokemon> {
        return NSFetchRequest<LikedPokemon>(entityName: "LikedPokemon")
    }
    
    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var genera: String
    @NSManaged public var officialFrontDefault: String?
    @NSManaged public var dotFrontDefault: String?
    @NSManaged public var types: [String]
    
}

extension LikedPokemon {
    convenience init(context: NSManagedObjectContext,
                     id: Int,
                     name: String,
                     genera: String,
                     officialFrontDefault: String?,
                     dotFrontDefault: String?,
                     types: [String]) {
        self.init(context: context)
        self.id = Int16(id)
        self.name = name
        self.genera = genera
        self.officialFrontDefault = officialFrontDefault
        self.dotFrontDefault = dotFrontDefault
        self.types = types
    }
}

extension LikedPokemon {
    func convertToPokemonCell() -> PokemonCell {
        let officialFrontDefaultURL = URL(string: self.officialFrontDefault ?? "")
        let dotFrontDefaultURL = URL(string: self.dotFrontDefault ?? "")
        return PokemonCell(id: Int(self.id),
                           name: self.name,
                           genera: self.genera,
                           officialFrontDefault: officialFrontDefaultURL,
                           dotFrontDefault: dotFrontDefaultURL,
                           types: self.types)
    }
}

extension LikedPokemon {
    static var preview: LikedPokemon {
        let pokemon = LikedPokemon.makePreviews(count: 1)
        return pokemon[0]
    }
    
    @discardableResult
    static func makePreviews(count: Int) -> [LikedPokemon] {
        var pokemons = [LikedPokemon]()
        let viewContext = PersistenceController.preview.container.viewContext
        for _ in 0..<count {
            let pokemon = LikedPokemon(context: viewContext)
            pokemon.id = 1
            pokemon.name = "테스트 이름"
            pokemon.genera = "테스트 종족"
            pokemon.officialFrontDefault = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
            pokemon.dotFrontDefault = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
            pokemon.types = ["grass", "poison"]
            pokemons.append(pokemon)
        }
        return pokemons
    }
}

extension LikedPokemon : Identifiable {
    
}
