//
//  DynamicCellsCollectionView.swift
//  StoreStudentFilter
//
//  Created by Manjeet Kumar on 12/09/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import UIKit

class DynamicCellsCollectionView: UIViewController {
    @IBOutlet weak var mCollectionView: UICollectionView!
    // Initially cells Height are nil, these will be set later for each index
    var heightOfCellInSection: [CGFloat?] = Array.init(repeating: nil, count: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mCollectionView.dataSource = self
        mCollectionView.delegate = self
        
        if let layout = mCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        }
        mCollectionView.register(UINib(nibName: "HeaderView", bundle: Bundle(for: HeaderView.self)), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }
    
    func simulateNetworkRequestToLoadCellData(index: Int) {
        if self.heightOfCellInSection[index] != nil {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(Int.random(in: 1...5)/10), execute: {
            if index % 10 == 0 {
                self.heightOfCellInSection[index] = 100
            } else {
                self.heightOfCellInSection[index] = CGFloat(Int.random(in: 15...30)) * CGFloat(10)
            }
            
            self.mCollectionView.reloadSections([index])
        })
    }
}

extension DynamicCellsCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return heightOfCellInSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellWithHeightConstraint", for: indexPath) as? CollectionViewCellWithHeightConstraint  {
            cell.config(height: heightOfCellInSection[indexPath.section])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        simulateNetworkRequestToLoadCellData(index: indexPath.section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 46)
    }
    
}

