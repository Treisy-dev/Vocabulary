//
//  SettingsCellComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 03.07.2024.
//

import SwiftUI

struct SettingsCellComponent<Content: View>: View {
    var title: String
    var content: Content

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            content
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: 60)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.alert)
        }
    }
}

#Preview {
    SettingsCellComponent(title: "TestTitle", content: Image(uiImage: .rightArrowIcon))
}
