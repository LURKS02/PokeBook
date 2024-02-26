//
//  PokeType.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/09.
//

import SwiftUI

enum ButtonSize {
    case big
    case small
    
    var fontSize: CGFloat {
        switch self {
        case .big: return 17
        case .small: return 12
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .big: return 12
        case .small: return 6
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .big: return 10
        case .small: return 5
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .big: return 15
        case .small: return 8
        }
    }
}

struct PokeType: View {
    let type: String
    let buttonSize: ButtonSize
    
    var body: some View {
        Text(typeName)
            .fontWeight(.bold)
            .font(.system(size: buttonSize.fontSize))
            .padding(.vertical, buttonSize.verticalPadding)
            .padding(.horizontal, buttonSize.horizontalPadding)
            .foregroundColor(.black)
            .background(Color(hexString: typeColor))
            .cornerRadius(buttonSize.cornerRadius)
    }

    var typeName: String {
        switch type {
        case "psychic": return "에스퍼"
        case "flying": return "비행"
        case "normal": return "노말"
        case "fire": return "불꽃"
        case "water": return "물"
        case "dragon": return "드래곤"
        case "electric": return "전기"
        case "grass": return "풀"
        case "ice": return "얼음"
        case "fighting": return "격투"
        case "poison": return "독"
        case "ground": return "땅"
        case "bug": return "벌레"
        case "rock": return "바위"
        case "ghost": return "고스트"
        case "dark": return "악"
        case "steel": return "강철"
        case "fairy": return "페어리"
        default: return type
        }
    }
    
    var typeColor: String {
        switch type {
        case "psychic": return "F95587"
        case "flying": return "A98FF3"
        case "normal": return "A8A77A"
        case "fire": return "EE8130"
        case "water": return "6390F0"
        case "dragon": return "6F35FC"
        case "electric": return "F7D02C"
        case "grass": return "7AC74C"
        case "ice": return "96D9D6"
        case "fighting": return "C22E28"
        case "poison": return "A33EA1"
        case "ground": return "E2BF65"
        case "bug": return "A6B91A"
        case "rock": return "B6A136"
        case "ghost": return "735797"
        case "dark": return "705746"
        case "steel": return "B7B7CE"
        case "fairy": return "D685AD"
        default: return "000000"
        }
    }
}

struct PokeType_Previews: PreviewProvider {
    static var previews: some View {
        PokeType(type: "psychic", buttonSize: .small)
    }
}
