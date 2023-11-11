//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Илья Подлесный on 14.10.2023.
//

import Foundation

protocol StatisticService {
    func store(correct count: Int, total amount: Int) -> GameRecord
    func getStats(correct count: Int, total amount: Int) -> String
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
} 
