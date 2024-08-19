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
                .font(.system(size: 30))
                .foregroundStyle(Color.elements)
                .padding(.top, 24)

            Text(descriptionText)
                .font(.system(size: 16))
                .foregroundStyle(Color.elements)
                .multilineTextAlignment(.center)

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
                    if let url = URL(string: "https://docs.google.com/document/d/1KgvdcHxZTHvysbu6JfdyZuQNautFL-6U0YM_EehhUj0/edit?usp=sharing") {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    Text("Terms of Use")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.elements)

                })
                Spacer()
                Button(action: {
                    if let url = URL(string: "https://docs.google.com/document/d/1xj_WSUfigUHhzTulr1uYCNp6pjAzhdZPmq98p5p8c9w/edit?usp=sharing") {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    Text("Privacy Policy")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.elements)

                })
                Spacer()
            }
            .padding(.bottom, 42)
            .padding(.top)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background {
            Rectangle()
                .fill(Color.onboardingFooter)
                .overlay(Color.elements.opacity(0.05).blur(radius: 20))
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
    @State var titleText: String = "Remember words \neffortlessly"
    @State var descriptionText: String = "Learn new words every day and expand your \nvocabulary"
    return OnboardingFooter(titleText: $titleText, descriptionText: $descriptionText)
        .environmentObject(OnboardingViewModel())
}
