//
//  BackButton.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/20.
//

import SwiftUI

struct BackButton: View {
    @Binding var presentationMode: PresentationMode
    
    var body: some View {
        Button(action: {
            self.$presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.get(.text(.primary)))
        }
    }
}
