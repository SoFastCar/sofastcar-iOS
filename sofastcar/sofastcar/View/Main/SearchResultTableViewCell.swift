//
//  SearchResultTableViewCell.swift
//  
//
//  Created by Woobin Cheon on 2020/09/07.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultCell"
    let symbolImageView = UIImageView()
    let socarZoneNameLabel = UILabel()
    let socarZoneAddrLabel = UILabel()
    let distanceFromMeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        symbolImageView.image = UIImage(named: "searchResult_annotation")
        symbolImageView.alpha = 0.25
        symbolImageView.contentMode = .scaleToFill
        
        socarZoneNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        socarZoneNameLabel.textColor = CommonUI.mainDark
        
        socarZoneAddrLabel.font = .systemFont(ofSize: 14, weight: .regular)
        socarZoneAddrLabel.textColor = .gray
        
        distanceFromMeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        distanceFromMeLabel.textColor = .gray
        
        [symbolImageView, socarZoneNameLabel, socarZoneAddrLabel, distanceFromMeLabel].forEach({
            contentView.addSubview($0)
        })
    }
    
    private func setupConstraint() {
        contentView.layoutMargins = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 30)
        let guide = contentView.layoutMarginsGuide
        [symbolImageView, socarZoneNameLabel, socarZoneAddrLabel, distanceFromMeLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        symbolImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview().offset(-10)
            $0.leading.equalTo(guide)
            $0.width.equalTo(33)
            $0.height.equalTo(33)
        })
        socarZoneNameLabel.snp.makeConstraints({
            $0.centerY.equalTo(symbolImageView)
            $0.leading.equalTo(symbolImageView.snp.trailing).offset(3)
        })
        socarZoneAddrLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview().offset(10)
            $0.leading.equalTo(symbolImageView.snp.trailing)
        })
        distanceFromMeLabel.snp.makeConstraints({
            $0.centerY.equalTo(symbolImageView)
            $0.trailing.equalTo(guide)
        })
    }
    
    public func setupConfiguration(placeName name: String, placeAddr address: String, distanceFromMe distance: String) {
        let coloredKeyword = NSMutableAttributedString(string: name)
        coloredKeyword.addAttribute(.foregroundColor, value: CommonUI.mainBlue, range: (name as NSString).range(of: searchKeyword))
        socarZoneNameLabel.attributedText = coloredKeyword
        
        socarZoneAddrLabel.text = address
        
        let convertToInt = Double(distance) ?? 0
        if convertToInt >= 1000 {
            distanceFromMeLabel.text = String(format: "%.1f km", convertToInt / 1000)  
        } else {
            distanceFromMeLabel.text = "\(distance)m"
        }         
    }
}
