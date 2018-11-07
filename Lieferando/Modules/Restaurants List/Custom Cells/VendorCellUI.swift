//
//  VendorCellUI.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/6/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import Cosmos

class VendorCellUI: UIView {
    
    var ratingStars : CosmosView = {
        let ra = CosmosView()
        ra.settings.emptyImage = UIImage(named: "ic_fav-empty")
        ra.settings.filledImage = UIImage(named: "ic_fav-fill")
        ra.settings.starSize = 12
        ra.settings.starMargin = 3
        ra.isUserInteractionEnabled = false
        ra.translatesAutoresizingMaskIntoConstraints = false
        return ra
    }()
    
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
        lbl.font = Themes.Fonts.Title
        lbl.textColor = .orange
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorStatus : UILabel = {
        let lbl = UILabel()
        lbl.text = "Busy"
        lbl.font = Themes.Fonts.Tags
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorRatingAvg : UILabel = {
        let lbl = UILabel()
        lbl.text = "3.9"
        lbl.font = Themes.Fonts.Tags
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorBestMatch : UILabel = {
        let lbl = UILabel()
        lbl.text = "1.0"
        lbl.font = Themes.Fonts.Tags
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorPopularity : UILabel = {
        let lbl = UILabel()
        lbl.text = "123.0"
        lbl.font = Themes.Fonts.Tags
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorDelivery : UILabel = {
        let lbl = UILabel()
        lbl.text = "150"
        lbl.font = Themes.Fonts.Tags
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorDistance : UILabel = {
        let lbl = UILabel()
        lbl.text = "5"
        lbl.font = Themes.Fonts.Tags
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorProductAvgPrice : UILabel = {
        let lbl = UILabel()
        lbl.text = "88"
        lbl.font = Themes.Fonts.Tags
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var vendorMinCost : UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.font = Themes.Fonts.Tags
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(vendorImage)
        self.addSubview(vStackView)
        
        self.vStackView.addArrangedSubviews([vendorName,
                                             vendorStatus,
                                             vendorMinCost,
                                             vendorDelivery,
                                             vendorDistance,
                                             vendorRatingAvg,
                                             vendorBestMatch,
                                             vendorProductAvgPrice,
                                             vendorPopularity])
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        self.addSubview(ratingStars)
        self.ratingStars.anchor(top: nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.vendorImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.vendorImage.anchor(top: nil,
                                left: self.leftAnchor,
                                bottom: nil,
                                right: nil,
                                topConstant: 0,
                                leftConstant: 0,
                                bottomConstant: 0,
                                rightConstant: 0,
                                widthConstant: 50,
                                heightConstant: 50)
        
        self.vStackView.anchor(top: self.topAnchor,
                               left: self.vendorImage.rightAnchor,
                               bottom: self.bottomAnchor,
                               right: self.rightAnchor,
                               topConstant: 10,
                               leftConstant: 10,
                               bottomConstant: 10,
                               rightConstant: 10,
                               widthConstant: 0,
                               heightConstant: 0)
    }
}
