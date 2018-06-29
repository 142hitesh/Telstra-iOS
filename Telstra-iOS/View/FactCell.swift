//
//  FactCell.swift
//  Telstra-iOS
//
//  Created by Hitesh on 6/29/18.
//  Copyright © 2018 Hitesh. All rights reserved.
//

import UIKit
import SDWebImage

class FactCell: UITableViewCell {

    //UI Components
    var iconImageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var descLabel: UILabel = UILabel()
    
    let titleFont = UIFont.boldSystemFont(ofSize: 16.0)
    let descFont = UIFont.systemFont(ofSize: 14.0)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIComponents()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descLabel.text = ""
        iconImageView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUIComponents() {
        //iconImageView
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        //iconImageView.backgroundColor = .lightGray
        contentView.addSubview(iconImageView)
        
        //titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = titleFont
        contentView.addSubview(titleLabel)
        
        //descLabel
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.font = descFont
        descLabel.numberOfLines = 0
        contentView.addSubview(descLabel)
        
        //set constraints for UI components
        let views: [String: Any] = [
            "iconImageView": iconImageView,
            "titleLabel": titleLabel,
            "descLabel": descLabel]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let iconVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[iconImageView(50)]-(>=10@750)-|",
            metrics: nil,
            views: views)
        allConstraints += iconVerticalConstraints
        
        let topRowHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[iconImageView(50)]-[titleLabel]-15-|",
            options: [.alignAllTop],
            metrics: nil, views: views)
        allConstraints += topRowHorizontalConstraints
        
        let secondRowHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[iconImageView]-[descLabel]-15-|",
            metrics: nil, views: views)
        allConstraints += secondRowHorizontalConstraints
        
        let titleToDescVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[titleLabel]-5-[descLabel]-10-|",
            metrics: nil,
            views: views)
        allConstraints += titleToDescVerticalConstraints
        
        //activate all constraints
        NSLayoutConstraint.activate(allConstraints)
    }
    
    func configure(_ fact: Fact) {
        
        //set title
        if let title = fact.title {
            titleLabel.text = title
        }
        
        //set description
        if let desc = fact.desc {
            descLabel.text = desc
        }
        
        //download icon image
        if let urlString = fact.imageURLString {
            iconImageView.sd_setImage(with: URL(string: urlString))
        }
    }
}
