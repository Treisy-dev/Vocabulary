//
//  OnboardingFooter.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 27.06.2024.
//

import SwiftUI

struct OnboardingFooter: View {
    @Binding var titleText: String
    @Binding var descriptionText: String
    @EnvironmentObject var viewModel: OnboardingViewModel
    var body: some View {
        VStack(spacing: 16) {
            Text(titleText)
                .multilineTextAlignment(.center)
                .font(.CharisSILR30)
                .foregroundStyle(Color.elements)
                .padding()
                .fixedSize(horizontal: false, vertical: true)

            Text(descriptionText)
                .font(.system(size: 16))
                .foregroundStyle(Color.elements)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)

            Button(action: {
                viewModel.switchState()
            }, label: {
                Text("Continue")
                    .foregroundStyle(Color.white)
                    .frame(minWidth: 200, maxWidth: 215, minHeight: 35, maxHeight: 40)
            })
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(Color.elements)
            }

            HStack{
                Spacer()
                Button(action: {
                    print("Terms of Use")
                }, label: {
                    Text("Terms of Use")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.elements)

                })
                Spacer()
                Button(action: {
                    print("Restore")
                }, label: {
                    Text("Restore")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.elements)

                })
                Spacer()
                Button(action: {
                    print("Privacy Policy")
                }, label: {
                    Text("Privacy Policy")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.elements)

                })
                Spacer()
            }
            .padding(.bottom, 42)
        }
        .frame(maxWidth: .infinity)
        .background {
           Rectangle()
                .fill(Color.appYellow)
                .clipShape(
                    .rect(
                        topLeadingRadius: 30,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 30
                    )
                )
        }

    }
}
#Preview {
    @State var titleText: String = "Remember words effortlessly"
    @State var descriptionText: String = "Learn new words every day and expand your vocabulary"
    return OnboardingFooter(titleText: $titleText, descriptionText: $descriptionText)
        .environmentObject(OnboardingViewModel())
}
