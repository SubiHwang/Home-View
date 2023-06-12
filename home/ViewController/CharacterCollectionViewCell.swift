//
//  CharacterCollectionViewCell.swift
//  home
//
//  Created by 황수비 on 2023/06/08.
//

import Foundation
import UIKit

class CharacterCollectionViewCell: UICollectionViewCell{
    
    
    @IBOutlet var CharacterImageView: UIImageView!
    
    var imageName : String = "" {
        didSet{
            // 쏄의 UI 설정
            self.CharacterImageView.image = UIImage(systemName: imageName)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("PostingCustomCollectionViewCell - awakeFromNib() called")
        contentView.backgroundColor = UIColor.clear
            contentView.layer.cornerRadius = 8
            contentView.layer.borderWidth = 0
            contentView.layer.borderColor = UIColor.clear.cgColor
    }

    
    
}
