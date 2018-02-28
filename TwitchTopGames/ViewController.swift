//
//  ViewController.swift
//  TwitchTopGames
//
//  Created by Eduardo Lombardi on 27/02/18.
//  Copyright © 2018 Eduardo Lombardi. All rights reserved.
//

import UIKit
import SDWebImage
import SystemConfiguration

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var uiCollectionView: UICollectionView?
    
    @IBOutlet weak var statusView: UIView?
    
    @IBOutlet weak var uiTitle: UILabel?
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    let numberOfCellsPerRow: CGFloat = 2
    var games: [Game] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCollectionViewCell
        
        guard let c = cell else {
            print("CELL error")
            return UICollectionViewCell()
        }
        
        
        c.uiName?.text = games[indexPath.row % games.count].name
        print("CELL NAME")
        print(c.uiName?.text)
        print("\n")
        guard let thumbUrl = games[indexPath.row % games.count].thumb else {
            return UICollectionViewCell()
        }
        let url = URL(string: thumbUrl)
        c.uiThumb?.sd_setImage(with:url, completed: nil)
    
        return c
        
    }
    
    func getData() {
        do {
            games = (try context?.fetch(Game.fetchRequest()))!
        } catch {
            print("Fetching Failed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flowLayout = uiCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let height = self.view.frame.size.height
            
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing)/numberOfCellsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height:height*0.5)
            
        }
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "https://api.twitch.tv/") else {
            return
        }
        
        var flags = SCNetworkReachabilityFlags()
        
        
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        
        if !isNetworkReachable(with: flags) {
            print("Sem internet")
            uiTitle?.text = "Twitch Top Games (Offline)"
            let statusBarColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0)
            statusBarView.backgroundColor = statusBarColor
            statusView?.backgroundColor = statusBarColor
            view.addSubview(statusBarView)
            return
        } else {
        uiTitle?.text = "Twitch Top Games (Online)"
        let statusBarColor = UIColor(red: 68/255, green: 81/255, blue: 218/255, alpha: 1.0)
        if(games.count == 0) {
        let x = DownloadData(downloadUrl:"https://api.twitch.tv/kraken/games/top")
        x.Download()
        }
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

