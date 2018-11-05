////
////  RestaurantsListVC.swift
////  Lieferando
////
////  Created by Mohamad Kaakati on 11/4/18.
////  Copyright © 2018 Mohamad Kaakati. All rights reserved.
////
//
//import UIKit
//import SwifterSwift
//import RealmSwift
//import Realm
//
//class RestaurantsListVC: UIViewController {
//    
//    let restaurantCellId = "RestaurantCellId"
//    
//    var restaurants : Results<ETAVendorsList>? {
//        didSet {
//            print(restaurants)
//            self.tableView.reloadData()
//        }
//    }
//    var notificationToken: NotificationToken?
//    
//    lazy var tableView : UITableView = {
//        let tbl = UITableView()
//        tbl.dataSource = self
//        tbl.delegate = self
//        tbl.backgroundColor = .white
//        tbl.rowHeight = UITableView.automaticDimension
//        tbl.register(UITableViewCell.self, forCellReuseIdentifier: self.restaurantCellId)
//        return tbl
//    }()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUIComponents()
//    }
//    
//    private func setupUIComponents() {
//        self.title = "Restaurants List"
//        self.view.addSubview(tableView)
//        setupConstraints()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        
//        self.fetchRestaurantsList()
//        notificationToken = RealmHandler.shared.realm.observe { [unowned self] note, realm in
////            self.restaurants = RealmHandler.shared.realm.objects(RestaurantEntity.self)
//        }
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        notificationToken?.invalidate()
//    }
//    
//    private func setupConstraints() {
//        self.tableView.anchor(top: self.view.topAnchor,
//                              left: self.view.leftAnchor,
//                              bottom: self.view.bottomAnchor,
//                              right: self.view.rightAnchor,
//                              topConstant: 0,
//                              leftConstant: 0,
//                              bottomConstant: 0,
//                              rightConstant: 0,
//                              widthConstant: 0,
//                              heightConstant: 0)
//    }
//    
//}
//
//extension RestaurantsListVC : UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.restaurants?.count ?? 5
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: self.restaurantCellId, for: indexPath)
//        if let restaurant = restaurants?[indexPath.row] {
//            cell.textLabel?.text = restaurant.name
//        }
//        return cell
//    }
//    
//}
//
//extension RestaurantsListVC : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(indexPath.row)")
//    }
//}
//
//extension RestaurantsListVC {
////    private func fetchRestaurantsList() {
////        self.restaurants = RealmHandler.shared.realm.objects(RestaurantEntity.self)
////    }
//}
