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
    
    let numberOfCellsPerRow: CGFloat = 2
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath)
        return cell
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        var height = self.view.frame.size.height
//        let width = self.view.frame.size.width
//        if (height * 0.45 < 252) {
//            height = 252
//        } else {
//            height *= 0.45
//        }
//
//        return CGSize(width: width/2, height:height )
//
//    }
    

//    (CGSize)collectionView:(UICollectionView *)collectionView
//    layout:(UICollectionViewLayout *)collectionViewLayout
//    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    CGFloat height = self.view.frame.size.height;
//    CGFloat width  = self.view.frame.size.width;
//    // in case you you want the cell to be 40% of your controllers view
//    return CGSizeMake(width*0.4,height*0.4)
//    }
//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flowLayout = uiCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let height = self.view.frame.size.height
            
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing)/numberOfCellsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height:height*0.5)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

