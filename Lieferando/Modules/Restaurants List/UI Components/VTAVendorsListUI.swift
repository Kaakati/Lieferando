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
    
    func userDidTapFilterButton(_ sortingValue : AvailableSortings)
//    func userDidSelectFilter(_ filterValue : String)
    func userSearchEvent(_ ofString: String)
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
    
    lazy var filterHiddenInput : UITextField = {
        let tf = UITextField()
        tf.inputView = filterPicker
        tf.isHidden = true
        tf.inputAccessoryView = setToolbar()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var searchInput : UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.init(hexString: "FAFAFA")
        tf.addPaddingLeft(15) // SwifterSwift for the rescue.
        tf.placeholder = "Search Restaurants"
        tf.inputAccessoryView = setToolbar()
        tf.addTarget(self, action: #selector(userSearchEvent(textField:)), for: UIControl.Event.editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
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
        self.addSubview(searchInput)
        self.addSubview(tableView)
        self.addSubview(filterHiddenInput)
    }

    private func setupConstraints() {
        // add constraints to subviews
        
        self.searchInput.anchor(top: self.topAnchor,
                                left: self.leftAnchor,
                                bottom: nil,
                                right: self.rightAnchor,
                                topConstant: 0,
                                leftConstant: 0,
                                bottomConstant: 0,
                                rightConstant: 0,
                                widthConstant: 0,
                                heightConstant: 44)
        
        self.tableView.anchor(top: searchInput.bottomAnchor,
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
    
    @objc private func userSearchEvent(textField: UITextField) {
        delegate?.userSearchEvent(searchInput.text!)
        if searchInput.text!.isEmpty { // Should Hide Keyboard if textField became Empty.
            endEditing(true)
        }
    }
    
    // Keyboard Toolbar
    @objc private func setToolbar() -> UIToolbar {
        let bar = UIToolbar()
        let close = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(doneTapped))
        bar.items = [close]
        bar.sizeToFit()
        
        return bar
    }
    
    @objc private func doneTapped() {
        endEditing(true)
    }
}

// MARK: - UITableView DataSource
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

// MARK: - UITableView Delegate
extension VTAVendorsListUI : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}

extension VTAVendorsListUI {

}

// MARK: - PickerView Implementation
extension VTAVendorsListUI : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.userDidTapFilterButton(AvailableSortings.init(rawValue: row)!)
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
    case reset
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
        case .reset:
            return "Reset"
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
            return "Avg. Product Price"
        case .deliveryCost:
            return "Delivery Cost"
        case .minimumCost:
            return "Minimum Cost"
        }
    }
    
    var sorting : String? {
        switch self {
        case .reset:
            return "Reset"
        case .status:
            return "status"
        case .favourite:
            return "isFavourite"
        case .bestMatch:
            return "sortingValues.bestMatch"
        case .newest:
            return "sortingValues.newest"
        case .rating:
            return "sortingValues.ratingAverage"
        case .distance:
            return "sortingValues.distance"
        case .popularity:
            return "sortingValues.popularity"
        case .avgPrice:
            return "sortingValues.averageProductPrice"
        case .deliveryCost:
            return "sortingValues.deliveryCosts"
        case .minimumCost:
            return "sortingValues.minCost"
        }
    }
}
