//
//  StatBar.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/26.
//

import SwiftUI

enum Stat {
    case total
    case hp
    case attack
    case defense
    case specialAttack
    case specialDefense
    case speed
    
    init(rawValue: String) {
        switch rawValue {
        case "total":
            self = .total
        case "hp":
            self = .hp
        case "attack":
            self = .attack
        case "defense":
            self = .defense
        case "special-attack":
            self = .specialAttack
        case "special-defense":
            self = .specialDefense
        case "speed":
            self = .speed
        default:
            self = .total
        }
    }
    
    var name: String {
        switch self {
        case .total:
            return "종족값"
        case .hp:
            return "HP"
        case .attack:
            return "공격"
        case .defense:
            return "방어"
        case .specialAttack:
            return "특수공격"
        case .specialDefense:
            return "특수방어"
        case .speed:
            return "스피드"
        }
    }
    
    var color: Color {
        switch self {
        case .total:
            return Color(hexString: "D7D7D7")
        case .hp:
            return Color(hexString: "EE6A6A")
        case .attack:
            return Color(hexString: "FA8F3D")
        case .defense:
            return Color(hexString: "8670BC")
        case .specialAttack:
            return Color(hexString: "FA517E")
        case .specialDefense:
            return Color(hexString: "698CDE")
        case .speed:
            return Color(hexString: "69BFDE")
        }
    }
}

struct StatBar: View {
    let stat: Stat
    let value: Int
    
    @State private var barMaxWidth: CGFloat = 0
    
    var body: some View {
        HStack {
            textStyle(Text("\(stat.name)"))
            statGraph
        }
    }
    
    private var statGraph: some View {
        ZStack(alignment: .leading) {
            backgroundGraph
            valueGraph
        }
    }
    
    private var backgroundGraph: some View { RoundedRectangle(cornerRadius: stat == .total ? 5 : 30)
            .stroke(Color(hexString: "D7D7D7"), lineWidth: 2)
            .frame(maxWidth: .infinity)
            .frame(height: 25)
            .overlay(
                GeometryReader { reader in
                    Color.clear
                        .onAppear {
                            self.barMaxWidth = reader.size.width
                        }
                }
            )
    }
    
    private var valueGraph: some View {
        RoundedRectangle(cornerRadius: stat == .total ? 5 : 30)
            .fill(stat.color)
            .frame(width: currentVarWidth,
                   height: 17)
            .overlay(alignment: .trailing) {
                Text("\(value)")
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(stat == .total ? .black : .white)
                    .padding(.trailing, 5)
            }
            .padding(4)
            .animation(.easeInOut(duration: 1), value: currentVarWidth)
    }
    
    var currentVarWidth: CGFloat {
        var percentage: Float = 0
        if (stat == .total) {
            percentage = Float(value) / 700
        }
        else {
            percentage = value > 200 ? 1 : Float(value) / 200
        }
        return CGFloat(percentage) * barMaxWidth
    }
    
    func textStyle(_ text: Text) -> some View {
        text
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(width: 60, alignment: .leading)
    }
}

struct StatBar_Previews: PreviewProvider {
    static var previews: some View {
        StatBar(stat: .attack, value: 145)
    }
}
