//
//  DownloadViewController.swift
//  TwitchTopGames
//
//  Created by Eduardo Lombardi on 27/02/18.
//  Copyright © 2018 Eduardo Lombardi. All rights reserved.
//

import UIKit
import SwiftyJSON

class DownloadData {
    
    var downloadUrl:String
    var games:NSMutableArray
    
    init(downloadUrl:String) {
        self.downloadUrl = downloadUrl
        self.games = []
    }
    
    func Download() {
        
        let urlString = downloadUrl
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            // Set headers
            request.setValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
            request.setValue("mafc61ius3g0bjpexh14yjyt4o1t5b", forHTTPHeaderField: "Client-ID")

            
            

            let completionHandler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                guard let d = data else {
                    return
                }
                
                let json = JSON(data:d)
               // print(json)
                for i in 0...5 {
                    let name =  json["top"][i]["game"]["localized_name"].string
                    let thumb = json["top"][i]["game"]["box"]["medium"].string
                    let game = Game(name: name, thumb: thumb)
                    self.games.add(game)
                }
                // Do something
            }
            URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        } else {
            // Something went wrong
        }
    }



}
