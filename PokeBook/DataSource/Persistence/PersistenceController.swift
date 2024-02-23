//
//  PersistenceController.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/22.
//

import CoreData
import Combine

class PersistenceController {
    static let shared = PersistenceController()
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        LikedPokemon.makePreviews(count: 5)
        return controller
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LikedPokemon")
        
        guard let description = container.persistentStoreDescriptions.first else { fatalError("failed to retrieve description") }
        
        if inMemory {
            description.url = URL(fileURLWithPath: "/dev/null")
        }
        
        description.setOption(true as NSNumber,
                              forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        description.setOption(true as NSNumber,
                              forKey: NSPersistentHistoryTrackingKey)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.name = "viewContext"
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        

        print("Core Data store URL: \(description.url)")
    }
}


extension PersistenceController {
    
    func newTaskContext() -> NSManagedObjectContext {
        let taskContext = container.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        return taskContext
    }
    
    func fetchPokemons(offset: Int, using repo: PokeRepository) -> AnyPublisher<Void, Never> {
        let pokemonPaginationURL = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=50")!
        return repo.fetchPokemonPagination(nextURL: pokemonPaginationURL)
            .flatMap { pokemonPagination -> AnyPublisher<Void, Never> in
                let pokemons = pokemonPagination.pokeList
                return self.importPokemons(from: pokemons)
            }
            .eraseToAnyPublisher()
    }
    
    func importPokemons(from pokemons: [PokemonCell]) -> AnyPublisher<Void, Never> {
        guard !pokemons.isEmpty else { return Empty().eraseToAnyPublisher() }
        
        let taskContext = newTaskContext()
        taskContext.name = "importContext"
        taskContext.transactionAuthor = "importPokemons"
        
        return Future { promise in
            taskContext.performAndWait {
                let batchInsertRequest = self.newBatchInsertRequest(with: pokemons)
                if let fetchResult = try? taskContext.execute(batchInsertRequest),
                   let batchInsertResult = fetchResult as? NSBatchInsertResult,
                   let success = batchInsertResult.result as? Bool, success { promise(.success(())) }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func newBatchInsertRequest(with pokemons: [PokemonCell]) -> NSBatchInsertRequest {
        var index = 0
        let total = pokemons.count
        
        let batchInsertRequest = NSBatchInsertRequest(entity: LikedPokemon.entity(), dictionaryHandler: { dictionary in
            guard index < total else { return true }
            dictionary.addEntries(from: pokemons[index].dictionaryValue)
            index += 1
            return false
        })
        return batchInsertRequest
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unsolved Error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func hasLiked(byID id: Int) -> LikedPokemon? {
        let fetchRequest: NSFetchRequest<LikedPokemon> = LikedPokemon.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let existingPokemon = try container.viewContext.fetch(fetchRequest)
            return existingPokemon.first
        } catch let error {
            print("Failed to fetch : \(error)")
            return nil
        }
    }
    
    //    func addLiked(id: Int, name: String, genera: String, officialFrontDefault: String, dotFrontDefault: String, types: [String]) {
    //        let existingPokemon = hasLiked(byID: id)
    //        if existingPokemon.isEmpty {
    //            let newPokemon = LikedPokemon(context: container.viewContext,
    //                                          id: id,
    //                                          name: name,
    //                                          genera: genera,
    //                                          officialFrontDefault: officialFrontDefault,
    //                                          dotFrontDefault: dotFrontDefault,
    //                                          types: types)
    //            saveContext()
    //            print("Pokemon inserted.")
    //        } else {
    //            print("Pokemon already exists.")
    //        }
    //    }
    
    func addLiked(byPokemon pokemon: PokemonCell) {
        let existingPokemon = hasLiked(byID: pokemon.id)
        if existingPokemon == nil {
            let newPokemon = LikedPokemon(context: container.viewContext,
                                          id: Int(pokemon.id),
                                          name: pokemon.name,
                                          genera: pokemon.genera,
                                          officialFrontDefault: pokemon.officialFrontDefault?.absoluteString,
                                          dotFrontDefault: pokemon.dotFrontDefault?.absoluteString,
                                          types: pokemon.types)
            saveContext()
        }
    }
    
    func deleteLiked(byID id: Int) {
        let existingPokemon = hasLiked(byID: id)
        if let pokemonToBeDeleted = existingPokemon {
            container.viewContext.delete(pokemonToBeDeleted)
            saveContext()
        }
    }
    
    func previewContext() -> NSManagedObjectContext {
        let context = container.viewContext
        let pokemon = LikedPokemon(context: context,
                                   id: 1,
                                   name: "이상해씨",
                                   genera: "씨앗포켓몬",
                                   officialFrontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
                                   dotFrontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                                   types: ["grass", "poison"])
        return context
    }
}
