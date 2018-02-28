//
//  ViewController.swift
//  TwitchTopGames
//
//  Created by Eduardo Lombardi on 27/02/18.
//  Copyright © 2018 Eduardo Lombardi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var uiCollectionView: UICollectionView?
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    let numberOfCellsPerRow: CGFloat = 2
    var games: [Game] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCollectionViewCell
        
        guard let c = cell else {
            return UICollectionViewCell()
        }
        
        c.uiName?.text = games[indexPath.row].name
    
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
        let x = DownloadData(downloadUrl:"https://api.twitch.tv/kraken/games/top")
        x.Download()
        
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

