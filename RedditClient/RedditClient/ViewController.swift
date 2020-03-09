//
//  ViewController.swift
//  RedditClient
//
//  Created by Axel Mosiejko on 08/03/2020.
//  Copyright © 2020 Axel Mosiejko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var redditData = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContent() 
    }

    func loadContent() {
        
        APIClient.shared.getFrontPage { (model) in
            self.redditData = model?.data?.data ?? []
            
            print(self.redditData.count)
            
            for entry in self.redditData {
                print(entry.childData?.author ?? "")
                print(entry.childData?.title ?? "")
                print(entry.childData?.num_comments ?? 0)
                print(" ")
            }
            
            
           DispatchQueue.main.async {
               // update the UI
           }
        }
    }
}

