//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Илья Подлесный on 14.10.2023.
//

import Foundation

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    let totalAccuracy: Double
    
    // метод сравнения по кол-ву верных ответов
    func isBetterThan(_ another: GameRecord) -> Bool {
        correct > another.correct
    }
}
