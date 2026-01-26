//
//  ErrorHandler.swift
//  TransitionDemo
//
//  Created by Alex on 26.01.2026.
//

import UIKit

final class ErrorHandler {

    static let shared = ErrorHandler()

    private init() {}

    // alert с ошибкой
    func show(error: Error, on viewController: UIViewController, retryAction: (() -> Void)? = nil) {
        let message: String

        if let networkError = error as? NetworkError {
            message = networkError.userFriendlyMessage
        } else {
            message = error.localizedDescription
        }

        show(title: "Ошибка", message: message, on: viewController, retryAction: retryAction)
    }

    // alert с кастомным сообщением
    func show(title: String, message: String, on viewController: UIViewController, retryAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        if let retryAction = retryAction {
            let retryActionButton = UIAlertAction(title: "Повторить", style: .default) { _ in
                retryAction()
            }
            alertController.addAction(retryActionButton)
        }

        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        DispatchQueue.main.async {
            viewController.present(alertController, animated: true)
        }
    }

    // Успешное сообщение
    func showSuccess(message: String, on viewController: UIViewController) {
        let alertController = UIAlertController(
            title: "Успешно",
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        DispatchQueue.main.async {
            viewController.present(alertController, animated: true)
        }
    }
}
