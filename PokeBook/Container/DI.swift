//
//  DI.swift
//  PokeBook
//
//  Created by 디해 on 2023/03/20.
//

import Foundation

class DIContainer {
    func getPokeRepository(isReal: Bool) -> PokeRepository {
        isReal ? RealPokeRepository() : MockRepository()
    }
}

class ServiceLocator {
    private var pokeRepo: PokeRepository?
    private var somethingOther: String?
    
    static var shared: ServiceLocator = .init()
    private init() { }
    
    func registerPokeRepo(repo: PokeRepository) {
        pokeRepo = repo
    }
    
    func resolvePokeRepo() -> PokeRepository {
        return pokeRepo ?? MockRepository()
    }
}
