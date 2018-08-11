//
//  CollectionViewController.swift
//  1.7 Task: Displaying Sets of Data: Collection View
//
//  Created by Eric Andersen on 3/26/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var batmanDataItems = [DataItem]()
    var jokerDataItems = [DataItem]()
    var allItems = [[DataItem]]()
    
    var count = 0
    var shiftingCount = 0
    
    var longPressGesture: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        for i in 1...29 {
            if i > 0 {
                batmanDataItems.append(DataItem(title: "Title #\(i)", kind: Kind.Batman, imageName: "bat\(i).jpg"))
                
            } else {
                batmanDataItems.append(DataItem(title: "Title #0\(i)", kind: Kind.Batman, imageName: "bat0\(i).jpg"))
            }
        }
        
        for i in 1...8 {
            if i > 0 {
                jokerDataItems.append(DataItem(title: "Another Title #\(i)", kind: Kind.Joker, imageName: "jok\(i).jpg"))
            } else {
                jokerDataItems.append(DataItem(title: "Another Title #0\(i)", kind: Kind.Joker, imageName: "jok0\(i).jpg"))
            }
        }
        
        allItems.append(batmanDataItems)
        allItems.append(jokerDataItems)
        
        super.viewDidLoad()
        
        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView?.addGestureRecognizer(longPressGesture)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItems[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DataItemCell
        let dataItem = allItems[indexPath.section][indexPath.item]
        cell.dataItem = dataItem
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! DataItemHeader
        var title = ""
        if let kind = Kind(rawValue: indexPath.section) {
            title = kind.description()
        }
        sectionHeader.title = title
        
        return sectionHeader
    }
    
    // MARK - Add Item
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        if(count%2 == 0){
            self.allItems[0].append(DataItem(title: "Title #\(count)", kind: Kind.Batman, imageName: "bat\(count+1).jpg"))
        }
        else{
            self.allItems[1].append(DataItem(title: "Another Title #\(count)", kind: Kind.Joker, imageName: "jok\(count + 1).jpg"))
        }
        count = count + 1
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDelegate
    
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        allItems[indexPath.section].remove(at: indexPath.row)
        
        
    //MARK - Delete Item
        
        self.collectionView?.performBatchUpdates({
            self.collectionView?.deleteItems(at: [indexPath])
        }) { (finished) in
            self.collectionView?.reloadItems(at: (self.collectionView?.indexPathsForVisibleItems)!)
        }
        
    }
    
    //MARK - Move Item
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
         print("Starting Index: \(sourceIndexPath.item)")
         print("Ending Index: \(destinationIndexPath.item)")
        
    allItems[sourceIndexPath.section].swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }
    
    
    
}
