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
    private var pushNotificationManager: PushNotificationManager = PushNotificationManager()

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
                        pushNotificationManager.requestNotificationAuthorization { granted in
                            if !granted {
                                showingAlert = true
                                isNotificationsEnabled = false
                            }
                        }
                    } else {
                        pushNotificationManager.checkNotificationAuthorization { isEnabled in
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
                                pushNotificationManager.clearAllNotifications()
                                pushNotificationManager.scheduleNotification(date: notificationTime)
                            }
                    }
                )
            }

            Text("Other")
                .foregroundStyle(Color.text)
                .font(.system(size: 20))
                .padding(.top)

            SettingsCellComponent(title: "Privacy Policy", content: Image(uiImage: .rightArrowIcon))
            SettingsCellComponent(title: "Terms of Use", content: Image(uiImage: .rightArrowIcon))
            SettingsCellComponent(title: "Share app", content: Image(uiImage: .rightArrowIcon))
            SettingsCellComponent(title: "Support", content: Image(uiImage: .rightArrowIcon))
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            pushNotificationManager.checkNotificationAuthorization { isEnable in
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
