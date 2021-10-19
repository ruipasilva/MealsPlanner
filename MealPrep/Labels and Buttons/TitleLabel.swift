//
//  TitleLabel.swift
//  MealPrep
//
//  Created by Rui Silva on 22/09/2021.
//

import UIKit

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
        adjustsFontSizeToFitWidth = true
        numberOfLines = 3
        translatesAutoresizingMaskIntoConstraints = false
    }

}
