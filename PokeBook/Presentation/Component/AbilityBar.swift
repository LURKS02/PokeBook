//
//  AbilityBar.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/26.
//

import SwiftUI

struct AbilityBar: View {
    let abilityNameMaxWidth:CGFloat = 100.0
    let boxPadding:CGFloat = 7.0
    let textPadding:CGFloat = 10.0
    let hiddenAbilityColor:String = "FFACC2"
    let normalAbilityColor:String = "E4E4E4"
    
    let name: String
    let flavorText: String
    let isHidden: Bool
    
    var body: some View {
        HStack() {
            Spacer()
            
            Text(name)
                .fontWeight(.semibold)
                .frame(width:abilityNameMaxWidth)
            
            Text(flavorText)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(textPadding)
                .background() {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.white)
                }
        }
        .padding(.vertical, boxPadding)
        .padding(.trailing, boxPadding)
        .background() {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(hexString: isHidden ? hiddenAbilityColor : normalAbilityColor))
        }
    }
}

struct AbilityBar_Previews: PreviewProvider {
    static var previews: some View {
        AbilityBar(name: "능력",
                   flavorText: "겁나 쎕니다.",
                   isHidden: true)
    }
}
