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
            
            self.stopRefreshAnimation()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func startRefreshAnimation(){
        self.refreshControl.beginRefreshing()
    }
    
    func stopRefreshAnimation(){
        DispatchQueue.main.async {
            if let refControl = self.tableView.refreshControl {
                if refControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailSegue"{
            let detailVC = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            if let data = redditData[indexPath.row].childData {
                detailVC.data = data
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.redditData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Not the best workaround. This should normally will be done server side.
        if let data = self.redditData[indexPath.row].childData {
            if Utils.isDismissEntry(name: data.name ?? "") {
                return 0
            }
        }
        
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell {
            if let data = self.redditData[indexPath.row].childData {
                cell.loadCellDataWith(data: data)
            }
            cell.selectionStyle = .none
            cell.tag = indexPath.row
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HomeTableViewCell {
            cell.unreadIndicator.isHidden = true
        }
        performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
    }

}

extension ViewController: HomeTableViewCellDelegate {
    func onDismissPost(tag: Int) {
        if let data = self.redditData[tag].childData {
            Utils.setDismiss(name: data.name ?? "")
            self.redditData.remove(at: tag)
            self.tableView.deleteRows(at: [IndexPath(row: tag, section: 0)], with: .left)
        }
        
    }
}
