//
//  InsuranceMenuHeaderView.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class InsuranceMenuHeaderView: UIView {

    let titleLabel = UILabel()
    let discriptionLabel = UILabel()
    let questionMarkButton = UIButton()
    lazy var questionMarkImageConfig = UIImage.SymbolConfiguration(pointSize: 25)
    lazy var questionMarkImage = UIImage(systemName: "questionmark.circle", withConfiguration: self.questionMarkImageConfig)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemYellow
        
        titleLabel.text = "차량손해면책 상품 선택"
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        
        self.addSubview(titleLabel)
        
        discriptionLabel.text = "사고 시, 회원님이 부담할 최대한도 금액 보장 상품입니다."
        discriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        discriptionLabel.textColor = .darkGray
        self.addSubview(discriptionLabel)
        
        questionMarkButton.setImage(questionMarkImage, for: .normal)
        questionMarkButton.tintColor = .black
        self.addSubview(questionMarkButton)
    }
    
    private func setupConstraint() {
        [titleLabel, discriptionLabel, questionMarkButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(self).offset(10)
            $0.leading.equalToSuperview()
        })
        
        discriptionLabel.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
        })
        
        questionMarkButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-5)
        })
    }
    
}
