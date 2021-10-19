//
//  SmallTitleLabel.swift
//  MealPrep
//
//  Created by Rui Silva on 29/09/2021.
//

import UIKit

class SmallTitleLabel: UILabel {
    
    var titleLabel: String!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(titleLabel: String) {
        super.init(frame: .zero)
        self.text = titleLabel
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
    }

}
