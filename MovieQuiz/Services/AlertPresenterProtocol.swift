//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Илья Подлесный on 14.10.2023.
//

import UIKit

protocol AlertPresenterProtocol {
    var delegate: AlertPresenterDelegate? { get set }
    func showResult(quiz result: AlertModel)
}
