//
//  CarListTableViewController.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CarListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        tableView.register(CarListTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CarListTableViewHeader.identifier)
        tableView.register(CarListTableViewCell.self, forCellReuseIdentifier: CarListTableViewCell.identifier)
        
        
        preferredContentSize = CGSize(width: 300, height: 400)
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableViewCell.identifier, for: indexPath) as? CarListTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CarListTableViewHeader.identifier) as? CarListTableViewHeader else { return UIView() }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }

}
