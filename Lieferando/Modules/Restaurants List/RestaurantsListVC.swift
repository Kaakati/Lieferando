//
//  RestaurantsListVC.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/4/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import SwifterSwift

class RestaurantsListVC: UIViewController {

    let restaurantCellId = "RestaurantCellId"
    
    lazy var tableView : UITableView = {
        let tbl = UITableView()
        tbl.dataSource = self
        tbl.delegate = self
        tbl.backgroundColor = .white
        tbl.rowHeight = UITableView.automaticDimension
        tbl.register(UITableViewCell.self, forCellReuseIdentifier: self.restaurantCellId)
        return tbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
        // Do any additional setup after loading the view.
    }
    
    private func setupUIComponents() {
        self.title = "Restaurants List"
        self.view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.tableView.anchor(top: self.view.topAnchor,
                              left: self.view.leftAnchor,
                              bottom: self.view.bottomAnchor,
                              right: self.view.rightAnchor,
                              topConstant: 0,
                              leftConstant: 0,
                              bottomConstant: 0,
                              rightConstant: 0,
                              widthConstant: 0,
                              heightConstant: 0)
    }
    
}

extension RestaurantsListVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.restaurantCellId, for: indexPath)
        cell.textLabel?.text = "Demo Cell"
        return cell
    }
    
}

extension RestaurantsListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}

