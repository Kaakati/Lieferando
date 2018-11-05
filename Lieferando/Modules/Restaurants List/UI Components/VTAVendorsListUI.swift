//
//  VTAVendorsListUI.swift
//  Lieferando
//
//  Created Mohamad Kaakati on 11/5/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import SwifterSwift

// MARK: VTAVendorsListUI Delegate -
/// VTAVendorsListUI Delegate
protocol VTAVendorsListUIDelegate {
  // Send Events to Module View, that will send events to the Presenter; which will send events to the Receiver e.g. Protocol OR Component.
}

// MARK: VTAVendorsListUI Data Source -
/// VTAVendorsListUI Data Source
protocol VTAVendorsListUIDataSource {
	  // This will be implemented in the Module View.
	  /// Get Object for the UI
	  func objectFor(view: VTAVendorsListUI) -> Results<ETAVendorsList>?
}

class VTAVendorsListUI: UIView {

    var delegate: VTAVendorsListUIDelegate?
    var dataSource: VTAVendorsListUIDataSource?
    
    let restaurantCellId = "RestaurantCellId"
    
    var object : Results<ETAVendorsList>? {
        didSet {
            print(object)
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView : UITableView = {
        let tbl = UITableView()
        tbl.dataSource = self
        tbl.delegate = self
        tbl.backgroundColor = .white
        tbl.rowHeight = UITableView.automaticDimension
        tbl.register(VendorCell.self, forCellReuseIdentifier: self.restaurantCellId)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        setupConstraints()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
    }

    private func setupUIElements() {
        // arrange subviews
        self.addSubview(tableView)
    }

    private func setupConstraints() {
        // add constraints to subviews
        self.tableView.anchor(top: self.topAnchor,
                              left: self.leftAnchor,
                              bottom: self.bottomAnchor,
                              right: self.rightAnchor,
                              topConstant: 0,
                              leftConstant: 0,
                              bottomConstant: 0,
                              rightConstant: 0,
                              widthConstant: 0,
                              heightConstant: 0)
    }

	/// Reloading the data and update the ui according to the new data
	func reloadData() {
		// Should update UI
		self.object = dataSource?.objectFor(view: self)
	}
}

extension VTAVendorsListUI : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.object?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.restaurantCellId, for: indexPath) as?  VendorCell else {
            fatalError("Faild to deqeue VendorCell")
        }
        if let restaurant = self.object?[indexPath.row] {
            cell.object = restaurant
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension VTAVendorsListUI : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}

extension VTAVendorsListUI {
//    private func fetchRestaurantsList() {
//        self.restaurants = RealmHandler.shared.realm.objects(RestaurantEntity.self)
//    }
}
