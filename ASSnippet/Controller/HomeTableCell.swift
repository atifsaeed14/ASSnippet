//
//  HomeTableCell.swift
//  ASSnippet
//

import UIKit

class HomeTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var titleLabel: UILabel!
    var dataSource: [String] = [String]()

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            
            let cellNib = UINib(nibName: "TagCollectionCell", bundle: nil)
            self.collectionView.register(cellNib, forCellWithReuseIdentifier: "TagCollectionCell")
        }
    }
}

extension HomeTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionCell", for: indexPath) as! TagCollectionCell
        let name = dataSource[indexPath.row]
        cell.tagLabel.text = name.uppercased()
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.cornerRadius = cell.contentView.frame.height / 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = dataSource[indexPath.row]
        let size: CGSize? = name.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)])
        return CGSize(width: (size?.width)!+45, height: 20)
    }
}
