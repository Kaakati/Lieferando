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
    func userDidTapFavouriteBtn(_ forObjectID: String)
    
    func userDidTapFilterButton()
//    func userDidSelectFilter(_ filterValue : String)
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
    
    lazy var filterPicker : UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = UIColor.init(hexString: "FAFAFA")
        pv.dataSource = self
        pv.delegate = self
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
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
        self.addSubview(filterPicker)
    }

    private func setupConstraints() {
        // add constraints to subviews
        self.filterPicker.anchor(top: nil,
                                 left: self.leftAnchor,
                                 bottom: self.bottomAnchor,
                                 right: self.rightAnchor,
                                 topConstant: 0,
                                 leftConstant: 0,
                                 bottomConstant: 0,
                                 rightConstant: 0,
                                 widthConstant: 0,
                                 heightConstant: 0)
        
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
        
        cell.favClousre = { [unowned self] in
            self.delegate?.userDidTapFavouriteBtn(self.object?[indexPath.row].id ?? "")
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

// MARK: - PickerView Implementation
extension VTAVendorsListUI : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(AvailableSortings.init(rawValue: row)?.stringValue ?? "N/A")
//        delegate?.userDidSelectFilter(AvailableSortings.init(rawValue: row)?.stringValue ?? "N/A")
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AvailableSortings.init(rawValue: row)?.stringValue ?? "N/A"
    }
}

extension VTAVendorsListUI : UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let pickerData = AvailableSortings.init(rawValue: row)?.stringValue ?? "N/A"
        let title = NSAttributedString(string: pickerData,
                                       attributes: [NSAttributedString.Key.font : Themes.Fonts.Tags,
                                                    NSAttributedString.Key.foregroundColor : UIColor.orange])
        return title
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AvailableSortings.allCases.count
    }
}


enum AvailableSortings : Int, CaseIterable {
    case status
    case favourite
    case bestMatch
    case newest
    case rating
    case distance
    case popularity
    case avgPrice
    case deliveryCost
    case minimumCost
    
    var stringValue : String? {
        switch self {
        case .status:
            return "Status"
        case .favourite:
            return "Favourite"
        case .bestMatch:
            return "Best Match"
        case .newest:
            return "Newest"
        case .rating:
            return "Rating"
        case .distance:
            return "Distance"
        case .popularity:
            return "Popularity"
        case .avgPrice:
            return "Product Price"
        case .deliveryCost:
            return "Delivery Cost"
        case .minimumCost:
            return "Minimum Cost"
        }
    }
}
