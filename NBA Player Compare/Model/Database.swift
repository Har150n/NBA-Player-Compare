//
//  Database.swift
//  NBA Player Compare
//
//  Created by Harrison Shu on 6/28/22.
//

import Foundation

protocol PlayerDelegate {
    func updateStats(pd: PlayerDisplay)
}

class Database {
    var delegate: PlayerDelegate?
    
    func getPlayer(id: String, season: String) {
        let urlString = "https://api-nba-v1.p.rapidapi.com/players/statistics?id=\(id)&season=\(season)"
        print("url string - " + urlString)
        let headers = [
            "X-RapidAPI-Key": "6c8e5b4100mshcf687520fc5ddcbp1ee98djsn49819b21210c",
            "X-RapidAPI-Host": "api-nba-v1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
                if let safeData = data {
                    self.parseJSON(playerData: safeData, season: season)
                }
            }
        })
        dataTask.resume()
    }
    

    func parseJSON(playerData: Data, season: String) {
        let decoder = JSONDecoder()
        do {
            print(String(decoding:playerData, as:UTF8.self))
            let playerGames = try decoder.decode(Player.self, from: playerData)
            generatePlayerAverage(player: playerGames, season: season)
        } catch {
            print(error)
        }
    }
    
    func generatePlayerAverage(player: Player, season : String) {
        var firstname: String
        var lastname: String
        var pointTotal: Float = 0.0
        var rebTotal: Float = 0.0
        var assistTotal: Float = 0.0
        var blockTotal: Float = 0.0
        var gameCount: Float = 0
        if player.response.count > 0 {
            for player in player.response {
                if(player.points != nil) {
                    gameCount += 1
                    pointTotal += player.points!
                    rebTotal += player.totReb!
                    assistTotal += player.assists!
                    blockTotal += player.blocks!
                }
            }
            firstname = player.response[0].player.firstname
            lastname = player.response[0].player.lastname
            let pd = PlayerDisplay(firstname: firstname, lastname: lastname, season: season, ppg: pointTotal/gameCount, rpg: rebTotal/gameCount, apg: assistTotal/gameCount, bpg: blockTotal/gameCount)
            self.delegate?.updateStats(pd: pd)
             
        } else {
            print("error: there are no statistics for this year")
        }
    }
}
