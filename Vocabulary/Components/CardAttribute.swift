//
//  CardAttribute.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI

struct CardAttribute: View {
    var text: String
    var body: some View {
        Text(text)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .foregroundColor(.text)
            .font(.system(size: 16))
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.appYellow.opacity(0.2))
            }
    }
}

#Preview {
    CardAttribute(text: "thinking")
}
