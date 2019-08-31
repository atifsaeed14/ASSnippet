//
//  TagCollectionCell.swift
//  ASSnippets
//

import UIKit

class TagCollectionCell: UICollectionViewCell {
    
    
    // MARK:- Class Properties
    
    @IBOutlet weak var tagLabel: UILabel! {
        didSet {
            tagLabel.font = UIFont.systemFont(ofSize: 12.0)
        }
    }
    
    // MARK:- Cell Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.tagLabel.preferredMaxLayoutWidth = 1000
    }

}
