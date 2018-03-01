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
import CoreData


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CollectionViewProtocol {
    
    @IBOutlet weak var uiCollectionView: UICollectionView?
    @IBOutlet weak var statusView: UIView?
    @IBOutlet weak var statusLabel: UILabel?
    @IBOutlet weak var uiTitle: UILabel?
    let refresher = UIRefreshControl()
    
    let x = DownloadData(downloadUrl:"https://api.twitch.tv/kraken/games/top")
    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    let numberOfCellsPerRow: CGFloat = 2
    var games: [Game] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 + x.offset * 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCollectionViewCell
        
        guard let c = cell else {
        return UICollectionViewCell()
        }
        
        
        for element in games {
            print(element.name)
        }

        
        if(games.count > indexPath.row) {
            
        c.uiName?.text = games[indexPath.row ].name
        
        guard let thumbUrl = games[indexPath.row].thumb else {
            c.uiThumb?.image = UIImage(named: "Fortnite-136x190")
            c.uiName?.text = "stub"
            return c
        }
        let url = URL(string: thumbUrl)
        c.uiThumb?.sd_setImage(with:url, completed: nil)
        }
        
        
        return c
        
    }
    
    func didReceiveData() {
        
        DispatchQueue.main.async {
            self.getData()
            self.uiCollectionView?.reloadData()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let offset = 10 + x.offset * 10
        print("OFFSET")
        print(offset)
        print(indexPath.row)
        print("\n")
        
        if indexPath.row + 1  == offset && indexPath.row > offset - 2  {
                        x.offset += 1
                        x.Download()

        }
    }
    

    
    func getData() {
        do {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
            guard let data = try context?.fetch(fetchRequest) as? [Game] else {
                return
            }
            games = data

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
        uiCollectionView?.alwaysBounceVertical = true
        
        refresher.addTarget(self, action: #selector(updateData), for: .valueChanged)
        uiCollectionView?.addSubview(refresher)
        
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "https://api.twitch.tv/") else {
            return
        }
        
        var flags = SCNetworkReachabilityFlags()
        
        
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        if !isNetworkReachable(with: flags) {
            offlineInterfaceConfig()
            self.getData()
            return
        } else {
            onlineInterfaceConfig()
            if(games.count == 0) {
                x.dataDelegate = self
                x.Download()
            }
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
   func offlineInterfaceConfig() {
        uiTitle?.text = "Twitch Top Games (Offline)"
        statusLabel?.text = "Falha no download das informações"
    
        let statusBarColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor
        statusView?.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    
        //uiCollectionView?.isHidden = true
        statusLabel?.isHidden = false
    
    
    }
    func onlineInterfaceConfig() {
        uiTitle?.text = "Twitch Top Games (Online)"
        
        let statusBarColor = UIColor(red: 68/255, green: 81/255, blue: 218/255, alpha: 1.0)
        
        uiCollectionView?.isHidden = false
        statusLabel?.isHidden = true
    }
    
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   @objc func updateData() {
        //updateData
        uiCollectionView?.reloadData()
        refresher.endRefreshing()
    }
}

