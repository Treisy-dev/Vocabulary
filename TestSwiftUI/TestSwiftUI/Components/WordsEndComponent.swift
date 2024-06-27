//
//  WordsEndComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 25.06.2024.
//

import SwiftUI

struct WordsEndComponent: View {
    @EnvironmentObject var footerManager: FooterManager
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("You went through all words for today!")
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
            Text("You can swipe them again or come back tomorrow to learn new words")
                .font(.system(size: 12))
                .italic()
                .multilineTextAlignment(.center)
            Button(action: {
                footerManager.isWordsEnd = false
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
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20, style: .circular)
                .fill(Color.greenAlert)
        }
        .frame(minWidth: 250, maxWidth: 270)
    }
}

#Preview {
    WordsEndComponent()
        .environmentObject(FooterManager())
}
