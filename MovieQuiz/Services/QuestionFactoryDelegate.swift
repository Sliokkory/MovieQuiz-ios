//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Илья Подлесный on 14.10.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
