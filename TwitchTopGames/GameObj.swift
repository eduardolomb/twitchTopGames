//
//  Game.swift
//  TwitchTopGames
//
//  Created by Eduardo Lombardi on 28/02/18.
//  Copyright © 2018 Eduardo Lombardi. All rights reserved.
//

import Foundation

class GameObj {
//    "top": [
//    {
//    "game": {
//    "name": "Fortnite",
//    "popularity": 146339,
//    "_id": 33214,
//    "giantbomb_id": 37030,
//    "box": {
//    "large": "https://static-cdn.jtvnw.net/ttv-boxart/Fortnite-272x380.jpg",
//    "medium": "https://static-cdn.jtvnw.net/ttv-boxart/Fortnite-136x190.jpg",
//    "small": "https://static-cdn.jtvnw.net/ttv-boxart/Fortnite-52x72.jpg",
//    "template": "https://static-cdn.jtvnw.net/ttv-boxart/Fortnite-{width}x{height}.jpg"
//    },
//    "logo": {
//    "large": "https://static-cdn.jtvnw.net/ttv-logoart/Fortnite-240x144.jpg",
//    "medium": "https://static-cdn.jtvnw.net/ttv-logoart/Fortnite-120x72.jpg",
//    "small": "https://static-cdn.jtvnw.net/ttv-logoart/Fortnite-60x36.jpg",
//    "template": "https://static-cdn.jtvnw.net/ttv-logoart/Fortnite-{width}x{height}.jpg"
//    },
//    "localized_name": "Fortnite",
//    "locale": ""
//    },
//    "viewers": 161974,
//    "channels": 8751
//    },
    
    let name:String?
    let thumb:String?
    
    init(name:String?,thumb:String?) {
        self.name = name
        self.thumb = thumb
    }
    
}
