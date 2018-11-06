//
//  VendorCell.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/5/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import Cosmos

class VendorCell: UITableViewCell {
    
    var favClousre : (() -> Void)?
    
    var object : ETAVendorsList? {
        didSet {
            if object != nil {
//                print(object?.name)
                self.ui.vendorName.text = object!.name
                self.ui.ratingStars.rating = object!.sortingValues!.ratingAverage
                if object!.isFavourite {
                    self.vendorFavouriteBtn.setImage(UIImage(named: "ic_fav-fill"), for: .normal)
                } else {
                    self.vendorFavouriteBtn.setImage(UIImage(named: "ic_fav-empty"), for: .normal)
                }
                
                updateConstraints()
                updateConstraintsIfNeeded()
                layoutIfNeeded()
                layoutSubviews()
            }
        }
    }
    
    var ui = VendorCellUI()
    
    lazy var vendorFavouriteBtn : UIButton = {
        let btn = UIButton()
        let btnImage = UIImage(named: "ic_fav-empty")!
        btn.setImageForAllStates(btnImage)
        btn.addTarget(self, action: #selector(favouriteBtnAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIComponents() {
        self.contentView.addSubview(ui)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        self.contentView.addSubview(vendorFavouriteBtn)
        self.vendorFavouriteBtn.anchor(top: self.contentView.topAnchor, left: nil, bottom: nil, right: self.contentView.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 24, heightConstant: 24)
        
        self.ui.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
    @objc func favouriteBtnAction() {
        favClousre?()
        //        itemCounters.changeTitle("1", atIndex: 1)
        print("Favourite pressed 👍")
    }


}
