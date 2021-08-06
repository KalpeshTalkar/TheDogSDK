//
//  BreedImageCell.swift
//  DemoApp
//
//  Created by Kalpesh on 24/04/21.
//

import UIKit

class BreedImageCell: UICollectionViewCell {

    @IBOutlet private weak var breedImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        breedImageView.image = nil
    }

    func setImage(imageUrl: String) {
        breedImageView.setImage(url: imageUrl, defaultImage: UIImage(named: "defaultDog"))
    }
    
}
