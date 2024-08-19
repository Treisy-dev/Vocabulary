//
//  SettingsView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 03.07.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var isNotificationsEnabled = false
    @State private var showTimePicker = false
    @State private var showingAlert = false
    @State private var notificationTime = Date()
    @State private var isShareSheetShowing = false

    var alert: Alert {
        Alert(
            title: Text("No access to push notifications"),
            message: Text("Please allow access to notifications so you receive new words every day"),
            primaryButton: .default(Text("Go to Settings")) {
                openAppSettings()
            },
            secondaryButton: .cancel()
        )
    }

    var body: some View {
        VStack(alignment: .leading) {
            CustomNavigationBarComponent(title: "Settings")
            Text("Main settings")
                .foregroundStyle(Color.text)
                .font(.system(size: 20))

            SettingsCellComponent(title: "Notifications",
                                  content: Toggle("", isOn: $isNotificationsEnabled)
                .onChange(of: isNotificationsEnabled) { newValue in
                    if newValue {
                        PushNotificationManager.shared.requestNotificationAuthorization { granted in
                            if !granted {
                                showingAlert = true
                                isNotificationsEnabled = false
                            }
                        }
                    } else {
                        PushNotificationManager.shared.checkNotificationAuthorization { isEnabled in
                            if !isEnabled {
                                showingAlert = true
                                isNotificationsEnabled = false
                            } else {
                                isNotificationsEnabled = false
                            }
                        }
                    }
                })

            if isNotificationsEnabled {
                SettingsCellComponent(title: "Set notifications time", content:
                    Button(action: {
                        showTimePicker.toggle()
                    }) {
                        Text(timeString(from: notificationTime))
                            .foregroundStyle(Color.text)
                    }
                    .padding(6)
                    .font(.system(size: 17))
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.black.opacity(0.12))
                    }
                    .sheet(isPresented: $showTimePicker) {
                        DatePicker("Select Time", selection: $notificationTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .presentationDetents([.height(250)])
                            .onDisappear {
                                PushNotificationManager.shared.clearAllNotifications()
                                PushNotificationManager.shared.scheduleNotification(date: notificationTime)
                            }
                    }
                )
            }

            Text("Other")
                .foregroundStyle(Color.text)
                .font(.system(size: 20))
                .padding(.top)

            SettingsCellComponent(title: "Privacy Policy", content: Image(uiImage: .rightArrowIcon))
                .onTapGesture {
                    if let url = URL(string: "https://docs.google.com/document/d/1xj_WSUfigUHhzTulr1uYCNp6pjAzhdZPmq98p5p8c9w/edit?usp=sharing") {
                        UIApplication.shared.open(url)
                    }
                }
            SettingsCellComponent(title: "Terms of Use", content: Image(uiImage: .rightArrowIcon))
                .onTapGesture {
                    if let url = URL(string: "https://docs.google.com/document/d/1KgvdcHxZTHvysbu6JfdyZuQNautFL-6U0YM_EehhUj0/edit?usp=sharing") {
                        UIApplication.shared.open(url)
                    }
                }
            SettingsCellComponent(title: "Share app", content: Image(uiImage: .rightArrowIcon))
                .onTapGesture {
                    isShareSheetShowing = true
                }
            SettingsCellComponent(title: "Support", content: Image(uiImage: .rightArrowIcon))
                .onTapGesture {
                    if let url = URL(string: "https://forms.gle/ukrKxqvBGQB9SBW69") {
                        UIApplication.shared.open(url)
                    }
                }
            Spacer()
        }
        .sheet(isPresented: $isShareSheetShowing, content: {
            BaseShareSheet(activityItems: ["https://apps.apple.com/app/id\(ConfigData.appId)"])
        })
        .padding(.horizontal)
        .onAppear {
            PushNotificationManager.shared.checkNotificationAuthorization { isEnable in
                isNotificationsEnabled = isEnable
            }
        }
        .alert(isPresented: $showingAlert, content: {
            alert
        })
        .toolbar(.hidden)
    }
}

private func timeString(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter.string(from: date)
}

private func openAppSettings() {
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
        return
    }
    if UIApplication.shared.canOpenURL(settingsUrl) {
        UIApplication.shared.open(settingsUrl)
    }
}

#Preview {
    SettingsView()
}
