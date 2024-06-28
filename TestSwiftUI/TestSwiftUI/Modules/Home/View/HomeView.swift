//
//  HomeView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Vocabulary")
                .font(.CharisSILR)
                .padding()

            Spacer()
            HomeFolderComponent(title: "Vocabulary", color: Color.greenAlert)
                .padding()

            HomeFolderComponent(title: "My Vocabulary", color: Color.appYellow)
            Spacer()

            HStack {
                Button(action: {
                   print("123")
                }, label: {
                    Image(uiImage: .settingsIcon)
                        .frame(width: 56, height: 56)
                        .background(Color.button.opacity(0.2))
                })
                .clipShape(Circle())

                Spacer()
                Button(action: {
                   print("123")
                }, label: {
                    Image(uiImage: .tutorialIcon)
                        .frame(width: 56, height: 56)
                        .background(Color.button.opacity(0.2))
                })
                .clipShape(Circle())

            }
            .padding()

        }
        .background{
            Color.appLight
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    HomeView()
}
