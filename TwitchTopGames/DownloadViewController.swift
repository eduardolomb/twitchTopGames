//
//  DownloadViewController.swift
//  TwitchTopGames
//
//  Created by Eduardo Lombardi on 27/02/18.
//  Copyright © 2018 Eduardo Lombardi. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DownloadData() {
        
        let urlString = "https://api.twitch.tv/kraken/games/top"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            
            // Set headers
            request.setValue("Accept", forHTTPHeaderField: "application/vnd.twitchtv.v5+json")
            request.setValue("Client-ID", forHTTPHeaderField: "mafc61ius3g0bjpexh14yjyt4o1t5b")
            let completionHandler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                guard let d = data else {
                    return
                }
                
                let json = try? JSONSerialization.jsonObject(with: d, options: [])
                
                print(json)
                // Do something
            }
            URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        } else {
            // Something went wrong
        }
    }



}
