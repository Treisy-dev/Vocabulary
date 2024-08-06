//
//  LaunchScreen.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 06.08.2024.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        VStack {
            Image(.launchScreen)
                .resizable()
                .frame(width: 388, height: 408)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Image(.onboardingBack)
                .resizable()
                .background {
                    Color.appLight
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LaunchScreen()
}
