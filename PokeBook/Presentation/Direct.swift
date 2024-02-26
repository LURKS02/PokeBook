//
//  File.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/19.
//

import Foundation

enum Direct {
    case none
    case up
    case down
    
    var direction: String {
        switch self {
        case .none: return "none"
        case .up: return "up"
        case .down: return "down"
        }
    }
}
