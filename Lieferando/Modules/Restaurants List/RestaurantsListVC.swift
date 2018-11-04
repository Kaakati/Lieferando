//
//  RestaurantsListVC.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/4/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit

class RestaurantsListVC: UIViewController {

    let restaurantCellId = "RestaurantCellId"
    
    lazy var tableView : UITableView = {
        let tbl = UITableView()
        tbl.dataSource = self
        tbl.delegate = self
        tbl.backgroundColor = .white
        tbl.rowHeight = UITableView.automaticDimension
        return tbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
        // Do any additional setup after loading the view.
    }
    
    private func setupUIComponents() {
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
    }
    
}

extension RestaurantsListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.restaurantCellId, for: indexPath)
        return cell
    }
}

extension RestaurantsListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
