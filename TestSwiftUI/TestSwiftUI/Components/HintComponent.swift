//
//  AlertComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 20.06.2024.
//

import SwiftUI

struct HintComponent: View {
    @AppStorage("isFirstOpen") var isFirstOpen: Bool = true
    var body: some View {
        VStack(spacing: 20) {
            Text("Swipe left to go to the next card")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.text)
            Image(uiImage: .leftSwipeIcon)
            Text ("Swipe right if you want to go to the previous card")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.text)
            Image(uiImage: .rightSwipeIcon)
            Button(action: {
                isFirstOpen = false
            }, label: {
                Text("OK")
                    .foregroundStyle(Color.white)
                    .frame(minWidth: 200, maxWidth: 215, minHeight: 35, maxHeight: 40)
            })
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(Color.elements)
            }
        }
        .frame(minWidth: 300, maxWidth: 343, minHeight: 300, maxHeight: 358)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .circular)
                .fill(Color.alert)
        }
    }
}

#Preview {
    HintComponent()
}
