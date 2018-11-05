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

class VendorCell: UITableViewCell {
    
    var object : ETAVendorsList? {
        didSet {
            if object != nil {
                print(object?.name)
                self.vendorName.text = object!.name
                
                updateConstraints()
                updateConstraintsIfNeeded()
                layoutIfNeeded()
                layoutSubviews()
            }
        }
    }

    var vendorImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_chef")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var vStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    var vendorName : UILabel = {
        let lbl = UILabel()
        lbl.text = "Vendor Name"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorRatingAvg : UILabel = {
        let lbl = UILabel()
        lbl.text = "3.9"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorBestMatch : UILabel = {
        let lbl = UILabel()
        lbl.text = "1.0"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorStatus : UILabel = {
        let lbl = UILabel()
        lbl.text = "Busy"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorPopularity : UILabel = {
        let lbl = UILabel()
        lbl.text = "123.0"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorDelivery : UILabel = {
        let lbl = UILabel()
        lbl.text = "150"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorDistance : UILabel = {
        let lbl = UILabel()
        lbl.text = "5"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorProductAvgPrice : UILabel = {
        let lbl = UILabel()
        lbl.text = "88"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorMinCost : UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorFavouriteBtn : UIButton = {
        let btn = UIButton()
        let btnImage = UIImage(named: "ic_fav-empty")!
        btn.setImageForAllStates(btnImage)
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
        self.contentView.addSubview(vendorImage)
        self.contentView.addSubview(vStackView)
        
        self.vStackView.addArrangedSubviews([vendorName,
                                             vendorStatus,
                                             vendorMinCost,
                                             vendorDelivery,
                                             vendorDistance,
                                             vendorRatingAvg,
                                             vendorBestMatch])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.vendorImage.anchor(top: nil,
                                left: self.contentView.leftAnchor,
                                bottom: nil,
                                right: nil,
                                topConstant: 0,
                                leftConstant: 10,
                                bottomConstant: 0,
                                rightConstant: 15,
                                widthConstant: 50,
                                heightConstant: 50)
        
        self.vendorName.heightAnchor.constraint(equalToConstant: 21).isActive = true
        self.vendorStatus.heightAnchor.constraint(equalToConstant: 21).isActive = true
        self.vendorMinCost.heightAnchor.constraint(equalToConstant: 21).isActive = true
        self.vendorDelivery.heightAnchor.constraint(equalToConstant: 21).isActive = true
        self.vendorDistance.heightAnchor.constraint(equalToConstant: 21).isActive = true
        self.vendorRatingAvg.heightAnchor.constraint(equalToConstant: 21).isActive = true
        self.vendorBestMatch.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        self.vStackView.anchor(top: self.contentView.topAnchor,
                               left: self.vendorImage.rightAnchor,
                               bottom: self.contentView.bottomAnchor,
                               right: self.contentView.rightAnchor,
                               topConstant: 10,
                               leftConstant: 0,
                               bottomConstant: 10,
                               rightConstant: 10,
                               widthConstant: 0,
                               heightConstant: 0)
    }

}
