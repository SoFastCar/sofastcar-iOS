//
//  SearchResultTableVC.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/05.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SearchResultTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - Table view delegate

}
