//
//  CardPostCell.swift
//  Chat
//
//  Created by MacBookPro on 2017. 1. 3..
//  Copyright © 2017년 EDCAN. All rights reserved.
//

import UIKit
import VisualEffectView

class CardPostCell : UITableViewCell{
    var backgroundImage = UIImageView()
    var contentTextView = UITextView()
    var contentEffectView = VisualEffectView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        backgroundImage.contentMode = .scaleToFill
        self.contentView.addSubview(backgroundImage)
        
        contentEffectView.effect = UIBlurEffect(style: .regular)
        contentEffectView.layer.cornerRadius = 16
        contentEffectView.layer.masksToBounds = true
        self.contentView.addSubview(contentEffectView)
        
        contentTextView.font = UIFont.systemFont(ofSize: 16)
        contentTextView.textAlignment = .center
        contentTextView.isEditable = false
        contentTextView.layer.cornerRadius = 16
        contentTextView.layer.masksToBounds = true;
        contentTextView.textColor = .white
        contentTextView.backgroundColor = nil
        self.contentView.addSubview(contentTextView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func layoutSubviews() {
        let stringSize = size(for : self.contentTextView.text, width : 0, font : UIFont.systemFont(ofSize: 16))
        let stringHeight = stringSize.height
        let stringWidth = stringSize.width
        
        backgroundImage.frame = CGRect(
            x : 0,
            y : 0,
            width : self.frame.width,
            height : self.frame.height
        )
        contentEffectView.frame = CGRect(
            x : self.frame.width / 2 - stringWidth / 2 - 8,
            y : self.frame.height / 2 - stringHeight / 2 - 8,
            width : stringWidth + 16,
            height : stringHeight + 16
        )
        contentTextView.frame = contentEffectView.frame
    }

    func size(for string : String, width : CGFloat, font : UIFont) -> CGSize {
        let rect = string.boundingRect(
            with: CGSize(width : width, height : 0),
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: [NSFontAttributeName : font],
            context: nil
        )
        
        return rect.size
    }

    class func height() -> CGFloat{
        return 64 + 32
    }
}
