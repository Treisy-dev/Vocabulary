//
//  SavedAlertComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 20.06.2024.
//

import SwiftUI

struct SavedAlertComponent: View {
    var titleText: String
    var description: String?
    @State var timer: Timer?
    @EnvironmentObject var footerManager: FooterManager
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(titleText)
                    .font(.system(size: description == nil ? 16 : 20))
                Spacer()
                Button(action: {
                    closeAlert()
                }, label: {
                    Image(uiImage: .closeIcone)
                })
            }
            if description != nil {
                Text(description ?? "")
                    .font(.system(size: 16))
                    .italic()
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20, style: .circular)
                .fill(Color.greenAlert)
        }
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
               closeAlert()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func closeAlert() {
        timer?.invalidate()
        footerManager.isPhotoSaved = false
        footerManager.isWordShared = false
        footerManager.isWordSavedFavorite = false
    }
}

#Preview {
    SavedAlertComponent(titleText: "The word is saved to My Vocabulary", description: "You can find your words in My Vocabulary")
        .environmentObject(FooterManager())
}

#Preview {
    SavedAlertComponent(titleText: "The word is saved to your Photos")
        .environmentObject(FooterManager())
}
