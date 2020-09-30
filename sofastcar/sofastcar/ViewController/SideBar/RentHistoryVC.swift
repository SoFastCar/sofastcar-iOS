//
//  RentHistoryVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class RentHistoryVC: UITableViewController {
  // MARK: - Properties
  var reservations: [Reservation]?
  lazy var filterButtonImageView: UIImageView = {
    let imageView = UIImageView()
    if let image = UIImage(systemName: "slider.horizontal.3")?.cgImage {
      let rotationImage = UIImage(cgImage: image, scale: 2, orientation: .left)
      imageView.image = rotationImage
    }
    imageView.isUserInteractionEnabled = true
    let tapguesture = UITapGestureRecognizer.init(target: self, action: #selector(tapFilterButton))
    imageView.addGestureRecognizer(tapguesture)
    return imageView
  }()
  
  let topBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  let statusBar =  UIView()
  
  // MARK: - Life Cycle
  override init(style: UITableView.Style) {
    super.init(style: .grouped)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureNavigationContoller()
    configureStatusBar()
    configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationContoller()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    removeFilterImageViewInNavigationController()
    statusBar.alpha = 0
  }
  
  func configureStatusBar() {
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    guard let statusBarFrame = window?.windowScene?.statusBarManager?.statusBarFrame else { return }
    statusBar.frame = statusBarFrame
    statusBar.backgroundColor = .white
    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
  }
  
  private func configureNavigationContoller() {
    guard let navi = navigationController else { return print("navi Missing")}
    title = "이용내역"
    navi.isNavigationBarHidden = false
    navi.navigationBar.isHidden = false
    navi.navigationBar.prefersLargeTitles = true
    navi.navigationItem.largeTitleDisplayMode = .always
    navi.navigationBar.backgroundColor = .white
    navi.navigationBar.barTintColor = UIColor.white
    navi.navigationBar.tintColor = UIColor.black
    navi.navigationBar.addSubview(filterButtonImageView)
    filterButtonImageView.snp.makeConstraints {
      $0.bottom.trailing.equalTo(navi.navigationBar).offset(-10)
    }
  }
  
  private func removeFilterImageViewInNavigationController() {
    if let subViews = navigationController?.navigationBar.subviews {
      for view in subViews where view == filterButtonImageView {
        view.removeFromSuperview()
      }
    }
  }
  
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .systemGray6
    tableView.estimatedRowHeight = 700
    tableView.register(RentHistoryCell.self, forCellReuseIdentifier: RentHistoryCell.identifier)
    tableView.sectionHeaderHeight = 10
    tableView.sectionFooterHeight = 0
    tableView.separatorStyle = .none
  }
  
  // MARK: - Button Action
  @objc private func tapFilterButton() {
    print("tapFilterButton")
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RentHistoryVC {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = UITableViewCell()
      cell.configureContentViewTopBottomLayer()
      return cell
    }
    let cell = RentHistoryCell(style: .default, reuseIdentifier: RentHistoryCell.identifier)
    return cell
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return reservations?.count ?? 5
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.section == 0 ? 0 : UITableView.automaticDimension
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let reservationDetailTableVC = ReservationDetailTableVC(isReservationEnd: true)
    reservationDetailTableVC.modalPresentationStyle = .overFullScreen
    present(reservationDetailTableVC, animated: true, completion: nil)
  }
}
