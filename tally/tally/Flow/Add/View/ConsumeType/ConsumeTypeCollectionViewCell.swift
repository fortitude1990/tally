//
//  ConsumeTypeCollectionViewCell.swift
//  tally
//
//  Created by 李志敬 on 2019/3/8.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class ConsumeTypeCollectionViewCell: UICollectionViewCell {
    
     // MARK: - Lazy
    
    lazy var imageView: UIImageView = {
        let aImageView: UIImageView = UIImageView.init()
        aImageView.backgroundColor = UIColor.lightGray
        aImageView.image = UIImage.init(named: "category_e_beauty_normal")
        return aImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let aTitleLabel: UILabel = UILabel.init()
        aTitleLabel.textAlignment = NSTextAlignment.center
        aTitleLabel.font = UIFont.systemFont(ofSize: 12)
        aTitleLabel.text = "美容"
        aTitleLabel.textColor = UIColor.init(red: 70 / 255.0, green: 70 / 255.0, blue: 74 / 255.0, alpha: 1.0)
//        aTitleLabel.backgroundColor = UIColor.orange
        return aTitleLabel
    }()
    
     // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - SetupUI
    
    func setupUI(frame: CGRect) -> Void {
        
//        self.backgroundColor = UIColor.cyan
        
        
        let titleLabelHeight: CGFloat = 15
        self.addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect.init(x: 0, y: frame.height - titleLabelHeight, width: frame.width, height: titleLabelHeight)
        
        let imageViewWidth: CGFloat = frame.height - titleLabelHeight - 10
        let originX: CGFloat = (frame.width - imageViewWidth) / 2.0
        self.addSubview(self.imageView)
        self.imageView.frame = CGRect.init(x: originX, y: 5, width: imageViewWidth, height: imageViewWidth)
        self.imageView.layer.cornerRadius = imageViewWidth / 2.0
        self.imageView.clipsToBounds = true
        

        
    }
    
    
}
