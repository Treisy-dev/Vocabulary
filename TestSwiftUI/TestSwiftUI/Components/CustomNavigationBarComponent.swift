//
//  CustomNavigationBarComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import SwiftUI

struct CustomNavigationBarComponent: View {
    var title: String
//    @Environment(\.presentationMode) var presentationMode
//
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(uiImage: .exitArrowIcon)
                }
                .padding(.leading, 16)
                Spacer()
            }
            Text(title)
                .font(.CharisSILR)
                .foregroundColor(Color.text)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    }
}

#Preview {
    CustomNavigationBarComponent(title: "Tutorial")
}
