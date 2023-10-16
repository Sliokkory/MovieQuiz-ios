//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Илья Подлесный on 14.10.2023.
//

import Foundation

protocol QuestionFactoryProtocol {
    var delegate: QuestionFactoryDelegate? { get set }
    func requestNextQuestion(_ index: Int?)
}
