//
//  TutorialDescriptionComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import SwiftUI

struct TutorialDescriptionComponent: View {
    @Binding var titleText: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.alert)

            Text(titleText)
                .multilineTextAlignment(.center)
                .padding(16)
        }
        .frame(maxWidth: 343, maxHeight: 124)
    }
}


#Preview {
    @State var title = "Add words you don't know and want to memorize to My Vocabulary. So you can access them quickly"
    return TutorialDescriptionComponent(titleText: $title)
}
