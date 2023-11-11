//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Илья Подлесный on 14.10.2023.
//

import UIKit

final class ResultAlertPresenter: UIViewController, AlertPresenterProtocol {
    weak var delegate: AlertPresenterDelegate?
    // метод вывода алерта с результатом квиза
    func showResult(quiz result: AlertModel) {
        let alert = UIAlertController(
                title: result.title,
                message: result.message,
                preferredStyle: .alert
        )
        alert.view.accessibilityIdentifier = "Game results"
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            self.delegate?.didReceiveAlert()
        }
        
        alert.addAction(action)
        delegate?.present(alert, animated: true, completion: nil)
    }
}
