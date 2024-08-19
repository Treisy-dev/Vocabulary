//
//  View.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 15.08.2024.
//

import SwiftUI

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        // Обеспечиваем корректное размещение view в своем родительском представлении
        view?.translatesAutoresizingMaskIntoConstraints = false

        // Ограничение ширины представления размером экрана (или любым другим значением)
        let targetSize = UIScreen.main.bounds.size
        view?.widthAnchor.constraint(equalToConstant: targetSize.width).isActive = true

        // Устанавливаем высоту, которая охватывает все содержимое
        let targetHeight = view?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height ?? 0
        view?.bounds = CGRect(origin: .zero, size: CGSize(width: targetSize.width, height: targetHeight))
        view?.backgroundColor = .clear

        // Рендерим изображение с полным размером представления
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: targetSize.width, height: targetHeight))
        let fullImage = renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }

        return fullImage
    }
}
