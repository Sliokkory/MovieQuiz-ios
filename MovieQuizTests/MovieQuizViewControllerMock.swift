//
//  MovieQuizViewControllerMock.swift
//  MovieQuizTests
//
//  Created by Илья Подлесный on 11.11.2023.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    func show(quiz step: QuizStepViewModel) {
        
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func showNetworkError(message: String) {
        
    }
    
    var alertPresenter: AlertPresenterProtocol = ResultAlertPresenter()
}
