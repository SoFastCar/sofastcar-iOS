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
    let parkingPlaceNameLabel = UILabel()
    let parkingPlaceAddrLabel = UILabel()
    let parkingStackView = UIStackView()
    let distanceFromMeLabel = UILabel()
    let stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackView.addArrangedSubview(symbolImageView)
        parkingStackView.addArrangedSubview(parkingPlaceNameLabel)
        parkingStackView.addArrangedSubview(parkingPlaceAddrLabel)
        parkingStackView.axis = .vertical
        parkingStackView.alignment = .leading
        parkingStackView.distribution = .fillProportionally
        stackView.addArrangedSubview(parkingStackView)
        stackView.addArrangedSubview(distanceFromMeLabel)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        contentView.addSubview(stackView)
    }
    
    private func setupConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints({
            $0.top.equalTo(contentView)
            $0.leading.equalTo(contentView)
            $0.trailing.equalTo(contentView)
            $0.bottom.equalTo(contentView)
        })
    }
    
    public func setupConfiguration(symbol image: String, placeName name: String, placeAddr address: String, distanceFromMe distance: Int) {
        symbolImageView.image = UIImage(systemName: image)
        
        parkingPlaceNameLabel.text = name
        
        parkingPlaceAddrLabel.text = address
        
        distanceFromMeLabel.text = String(distance) 
    }
}
