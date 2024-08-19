//
//  BaseShareSheet.swift
//  Vocabulary
//
//  Created by Кирилл Щёлоков on 19.08.2024.
//

import SwiftUI

struct BaseShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
