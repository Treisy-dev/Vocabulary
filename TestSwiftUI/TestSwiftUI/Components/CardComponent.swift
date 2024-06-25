//
//  CardComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI

struct CardComponent: View {
    var cardData: Card
    @State var isShareTapped: Bool = false
    @EnvironmentObject var footerManager: FooterManager

    var body: some View {
        ScrollView {
            ZStack {
                Image(uiImage: UIImage(named: cardData.imageName) ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(minHeight: 478)

                VStack {
                    HStack {
                        Button(action: {

                        }) {
                            Image(uiImage: .closeIcone)
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding()
                                .background(Color.appLight.opacity(0.4))
                        }
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())

                        Spacer()

                        Button(action: {
                            self.isShareTapped = true
                        }) {
                            Image(uiImage: .shareIcon)
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding()
                                .background(Color.appLight.opacity(0.4))
                        }
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        .sheet(isPresented: $isShareTapped, content: {
                            ShareSheet(items: [UIImage(named: cardData.imageName) ?? .img, "\(cardData.title) - \(cardData.transcrtiption)", ])
                                .onDisappear {
                                    footerManager.isWordShared = true
                                }
                        })
                    }
                    .padding(.top, 38)
                    .padding(.horizontal)

                    Spacer()
                }
            }
            VStack {
                Spacer()

                VStack(alignment: .center, spacing: 4) {
                    Text(cardData.title)
                        .foregroundColor(.text)
                        .font(Font.CharisSILR)

                    Text(cardData.type)
                        .foregroundColor(.text)
                        .font(.system(size: 12))
                        .italic()

                    Text(cardData.transcrtiption)
                        .foregroundColor(.text)
                        .font(.system(size: 16))
                }
                .frame(minWidth: 250, maxWidth: 295, minHeight: 80, maxHeight: 96)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.appYellow)
                        .shadow(radius: 4)
                }
                .padding(.top, -60)

                Text(cardData.description)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.text)
                    .font(.system(size: 16))
                    .padding()

                Text(cardData.exampleText)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.text)
                    .font(.system(size: 16))
                    .italic()
                    .padding()

                HStack {
                    ForEach(cardData.atributes, id: \.self) { attribute in
                        CardAttribute(text: attribute)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    CardComponent(cardData: Card(id: "1", imageName: "img", title: "Sycophant", type: "adjective", transcrtiption: "[ˈsɪkəfənt]", description: "A person who acts obsequiously toward someone important in order to gain advantage.", soundName: "exampleSound", exampleText: "He surrounded himself with sycophants who constantly praised him, regardless of his actions.", atributes: ["abc", "abc", "abc"]))
        .environmentObject(FooterManager())
}
