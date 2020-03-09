//
//  HomeTableViewCell.swift
//  RedditClient
//
//  Created by Axel Mosiejko on 09/03/2020.
//  Copyright © 2020 Axel Mosiejko. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var userLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var titleTxt: UITextView!
    @IBOutlet var thumb: UIImageView!
    @IBOutlet var unreadIndicator: UIView!
    @IBOutlet var commentsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellDataWith(data: ChildData){
        userLbl.text = data.author ?? ""
        dateLbl.text = String(data.date ?? 0)
        titleTxt.text = data.title ?? ""
        commentsLbl.text = "\(data.num_comments ?? 0) comments"
        
        unreadIndicator.layer.cornerRadius = 5
    }
}
