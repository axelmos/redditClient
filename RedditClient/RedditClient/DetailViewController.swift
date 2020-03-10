//
//  DetailViewController.swift
//  RedditClient
//
//  Created by Axel Mosiejko on 10/03/2020.
//  Copyright © 2020 Axel Mosiejko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    public var data:ChildData!
    @IBOutlet var userLbl: UILabel!
    @IBOutlet var titleTxt: UITextView!
    @IBOutlet var thumb: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userLbl.text = data.author ?? ""
        titleTxt.text = data.title ?? ""
        
        DispatchQueue.main.async {
            if let url = URL.init(string: self.data.thumbnail ?? "") {
                self.thumb.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder_square"))
            }
        }
        
        Utils.setReadEntry(name: data.name ?? "")
    }
    
}
