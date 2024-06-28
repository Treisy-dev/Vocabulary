//
//  HomeFolderComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import SwiftUI

struct HomeFolderComponent: View {
    var title: String
    var color: Color
    var body: some View {
        Image(uiImage: .homeFolder)
            .renderingMode(.template)
            .foregroundStyle(color)
            .overlay {
                VStack {
                    Text(title)
                        .font(.CharisSILR)
                        .padding()
                    Button(action: {
                        print("Vocabulary")
                    }, label: {
                        Text("Learn")
                            .foregroundStyle(Color.white)
                            .frame(minWidth: 200, maxWidth: 215, minHeight: 35, maxHeight: 40)
                    })
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .circular)
                            .fill(Color.elements)
                    }
                }
            }
    }
}

#Preview {
    HomeFolderComponent(title: "Vocabulary", color: Color.appYellow)
}
