//
//  Player.swift
//  NBA Player Compare
//
//  Created by Harrison Shu on 6/28/22.
//

import Foundation

struct Player: Codable {
    var response : [Game]
}

struct Game: Codable {
    var player: Info
    var points: Float?
    var totReb: Float?
    var assists: Float?
    var blocks: Float?
}

struct Info: Codable {
    var id: Int
    var firstname: String
    var lastname: String
}
