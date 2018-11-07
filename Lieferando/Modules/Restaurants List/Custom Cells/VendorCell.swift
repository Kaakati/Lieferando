//
//  VendorCell.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/5/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import SwifterSwift
import Realm
import RealmSwift
import Cosmos

enum VendorStatus : String {
    case open = "Open"
    case closed = "Closed"
    case orderAhead = "Order Ahead"
    
    var statusColor : UIColor {
        switch self {
        case .open:
            return .green
        case .closed:
            return .red
        case .orderAhead:
            return .blue
        }
    }
}

class VendorCell: UITableViewCell {
    
    var favClousre : (() -> Void)?
    
    var object : ETAVendorsList? {
        didSet {
            if object != nil {

                self.ui.vendorName.text = object!.name
                self.ui.vendorStatus.text = object!.status.capitalized
                self.ui.vendorMinCost.text = "Min: " + object!.sortingValues!.minCost.string
                self.ui.vendorDelivery.text = "Delivery: " + object!.sortingValues!.deliveryCosts.string
                self.ui.vendorDistance.text = "Distance: " + object!.sortingValues!.distance.string
                self.ui.vendorBestMatch.text = "Match: " + object!.sortingValues!.bestMatch.string
                self.ui.vendorRatingAvg.text = "Rating: " + object!.sortingValues!.ratingAverage.string
                self.ui.vendorPopularity.text = "Popularity: " + object!.sortingValues!.popularity.string
                self.ui.vendorProductAvgPrice.text = "Avg. Price: " + object!.sortingValues!.averageProductPrice.string
                
                self.ui.ratingStars.rating = object!.sortingValues!.ratingAverage
                
                if object!.isFavourite {
                    self.vendorFavouriteBtn.setImage(UIImage(named: "ic_fav-fill"), for: .normal)
                } else {
                    self.vendorFavouriteBtn.setImage(UIImage(named: "ic_fav-empty"), for: .normal)
                }
                
                guard let vendorStatus = VendorStatus(rawValue: self.ui.vendorStatus.text!) else {
                    return
                }
                
                switch vendorStatus {
                case .open:
                    self.ui.vendorStatus.textColor = vendorStatus.statusColor
                case .closed:
                    self.ui.vendorStatus.textColor = vendorStatus.statusColor
                case .orderAhead:
                    self.ui.vendorStatus.textColor = vendorStatus.statusColor
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
        self.selectionStyle = .none
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
