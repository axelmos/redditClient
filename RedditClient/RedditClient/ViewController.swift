//
//  ViewController.swift
//  RedditClient
//
//  Created by Axel Mosiejko on 08/03/2020.
//  Copyright © 2020 Axel Mosiejko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var redditData = [Child]()
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.separatorInset = UIEdgeInsets.zero
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: UIControl.Event.valueChanged)
        self.tableView.refreshControl = refreshControl
        
        loadContent() 
    }
    
    @objc func reloadData(){
        startRefreshAnimation()
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
            self.stopRefreshAnimation()
            self.tableView.reloadData()
           }
        }
    }
    
    func startRefreshAnimation(){
        self.refreshControl.beginRefreshing()
    }
    
    func stopRefreshAnimation(){
        self.refreshControl.endRefreshing()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.redditData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell {
            if let data = self.redditData[indexPath.row].childData {
                cell.loadCellDataWith(data: data)
            }
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
