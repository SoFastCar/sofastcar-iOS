//
//  CarListTableViewController.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CarListTableViewController: UITableViewController {
    
    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        tableView.register(CarListTableViewHeader.self, 
                           forHeaderFooterViewReuseIdentifier: CarListTableViewHeader.identifier)
        tableView.register(CarListTableViewCell.self,
                           forCellReuseIdentifier: CarListTableViewCell.identifier)
        
        panGesture.delegate = self
//        tableView.addGestureRecognizer(panGesture)
        
    }
    @objc func didPan(_ pan: UIPanGestureRecognizer) {
        print(#function)
        let tableViewYOffset = round(view.frame.origin.y)
        let topPresentedY = round(view.frame.height * 0.09)
        let centerPresentedY = round(view.frame.height / 2)
        let bottomPresentedY = round(view.frame.height * 0.82)
        let borderBetweenTopCenter = round(topPresentedY + (centerPresentedY - topPresentedY) / 2)
        let borderBetrweenCenterBottom = round(centerPresentedY + (bottomPresentedY - centerPresentedY) / 2)
        
        print("top: \(topPresentedY), center: \(centerPresentedY), bottom: \(bottomPresentedY)")
        
        let location = pan.translation(in: view)
        switch pan.state {
        case .began:
            tableView.frame.size.height = view.frame.height
        case .changed:
            
            switch tableView.frame.origin.y {
            case topPresentedY...bottomPresentedY:
                
                tableView.frame.origin.y = round(location.y) + tableViewYOffset
                pan.setTranslation(.zero, in: tableView)
            case 0..<topPresentedY:
                print("top: \(topPresentedY), tableView: \(tableView.frame.origin.y)")
            default:
                print("bottom: \(bottomPresentedY), tableView: \(tableView.frame.origin.y)")
            }
//            if round(tableView.frame.origin.y) <= round(bottomPresentedY),
//                round(topPresentedY) <= round(tableView.frame.origin.y) {
//                tableView.frame.origin.y = location.y + tableViewYOffset
//                pan.setTranslation(.zero, in: tableView)
//                if tableView.frame.origin.y > centerPresentedY {
////                    view.backgroundColor = UIColor.black.withAlphaComponent(<#T##alpha: CGFloat##CGFloat#>)
//                } else {
//                    // do nothing
//                }
//            } else {
//                // do nothing
//            }
        case .ended:
            switch tableView.frame.origin.y {
            case ...topPresentedY:
                tableView.frame.origin.y = topPresentedY
            case topPresentedY..<borderBetweenTopCenter:
                tableView.frame.origin.y = topPresentedY
            case borderBetweenTopCenter...centerPresentedY:
                tableView.frame.origin.y = centerPresentedY
            case centerPresentedY..<borderBetrweenCenterBottom:
                tableView.frame.origin.y = centerPresentedY
            case borderBetrweenCenterBottom...bottomPresentedY:
                tableView.frame.origin.y = bottomPresentedY
            case bottomPresentedY...:
                tableView.frame.origin.y = bottomPresentedY
            default:
                print("Panning Error")
            }
//        case .ended:
//            switch tableView.frame.origin.y {
//            case (centerPresentedY + (bottomPresentedY - centerPresentedY) / 2)...bottomPresentedY:
//                tableView.frame.origin.y = bottomPresentedY
//            case centerPresentedY..<(centerPresentedY + (bottomPresentedY - centerPresentedY) / 2):
//                tableView.frame.origin.y = centerPresentedY
//            case (topPresentedY + (centerPresentedY - topPresentedY) / 2)...centerPresentedY:
//                tableView.frame.origin.y = centerPresentedY
//            case topPresentedY..<(topPresentedY + (centerPresentedY - topPresentedY) / 2):
//                tableView.frame.origin.y = topPresentedY
//            case ...topPresentedY:
//                tableView.frame.origin.y = topPresentedY
//            default:
//                tableView.frame.origin.y = bottomPresentedY
//            }
        default:
            break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let presentingVC = presentingViewController as? MainVC else { return }
        presentingVC.topSearchView.alpha = 1
        presentingVC.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableViewCell.identifier, for: indexPath)
            as? CarListTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = 
            tableView.dequeueReusableHeaderFooterView(withIdentifier: CarListTableViewHeader.identifier)
            as? CarListTableViewHeader else { return UIView() }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
}

extension CarListTableViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
