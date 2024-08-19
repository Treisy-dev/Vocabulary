//
//  SwipeIndicatorComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import SwiftUI

struct SwipeIndicatorComponent: View {
    let totalPoints: Int
    @Binding var currentPoint: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPoints, id: \.self) { index in
                if index == currentPoint {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.appYellow)
                        .frame(width: 28, height: 8)
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}

#Preview {
    @State var currentPoint = 1
    return SwipeIndicatorComponent(totalPoints: 3, currentPoint: $currentPoint)
}
