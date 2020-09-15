//
//  CollectionViewCellWithHeightConstraint.swift
//  SectionHeaderGlitch
//
//  Created by Manjeet Kumar on 14/09/20.
//  Copyright © 2020 Manjeet Kumar. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCellWithHeightConstraint: UICollectionViewCell {
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    
    func config(height: CGFloat? = nil) {
        self.heightContraint.constant = height ?? 200
    }

}
