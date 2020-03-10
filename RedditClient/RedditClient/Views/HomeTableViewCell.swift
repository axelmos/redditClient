//
//  HomeTableViewCell.swift
//  RedditClient
//
//  Created by Axel Mosiejko on 09/03/2020.
//  Copyright © 2020 Axel Mosiejko. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeTableViewCellDelegate {
    func onDismissPost(tag: Int)
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var userLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var titleTxt: UITextView!
    @IBOutlet var thumb: UIImageView!
    @IBOutlet var unreadIndicator: UIView!
    @IBOutlet var commentsLbl: UILabel!
    var delegate: HomeTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onDismissButtonPressed(_ sender: UIButton) {
        delegate.onDismissPost(tag: self.tag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellDataWith(data: ChildData){
        userLbl.text = data.author ?? ""
        dateLbl.text = Utils.formattedDate(unixDate: data.date ?? 0)
        titleTxt.text = data.title ?? ""
        commentsLbl.text = "\(data.num_comments ?? 0) comments"
        unreadIndicator.layer.cornerRadius = 5
        
        if Utils.isReadEntry(name: data.name ?? "") {
            unreadIndicator.isHidden = true
        } else {
            unreadIndicator.isHidden = false
        }
        
        DispatchQueue.main.async {
            
            if let url = URL.init(string: data.thumbnail ?? "") {
                self.thumb.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder_square"))
            }
        }
    }
}
