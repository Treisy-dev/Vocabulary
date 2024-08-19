//
//  CardComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI

struct CardComponent: View {
    var cardData: Card
    @Binding var cardImage: UIImage?
    @EnvironmentObject var footerManager: FooterManager

    var body: some View {
        ScrollView {
            ZStack {
                if let image = cardImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: UIApplication.shared.windows.first?.bounds.width, height: 478)
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.appLight)
                        .overlay {
                            ProgressView()
                        }
                        .edgesIgnoringSafeArea(.all)
                        .frame(minHeight: 478)
                }
            }
            VStack {
                Spacer()

                VStack(alignment: .center, spacing: 4) {
                    Text(cardData.word)
                        .foregroundColor(.text)
                        .font(Font.CharisSILR)

                    Text(cardData.partOfSpeach)
                        .foregroundColor(.text)
                        .font(.system(size: 12))
                        .italic()

                    Text(cardData.transcription)
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
                    .frame(maxWidth: (UIApplication.shared.windows.first?.bounds.width)! - 32)
                    .padding()

                Text(cardData.usageExample)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.text)
                    .font(.system(size: 16))
                    .italic()
                    .frame(maxWidth: (UIApplication.shared.windows.first?.bounds.width)! - 32)
                    .padding()

                HStack {
                    ForEach(cardData.synonyms.components(separatedBy: ", "), id: \.self) { attribute in
                        CardAttribute(text: attribute)
                    }
                    .frame(maxWidth: (UIApplication.shared.windows.first?.bounds.width)! - 32)
                }
            }
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    CardComponent(cardData: Card(word: "word", partOfSpeach: "partOfSpeech", transcription: "transcription", description: "description", usageExample: "usageExample", synonyms: "synonyms"), cardImage: .constant(.img))
        .environmentObject(FooterManager())
}
