//
//  TableViewController.swift
//  Telstra-iOS
//
//  Created by Hitesh on 6/29/18.
//  Copyright © 2018 Hitesh. All rights reserved.
//

import UIKit

// MARK: - Country and Fact Models

struct Country: Codable {
    let title: String
    let facts: [Fact]
    
    enum CodingKeys: String, CodingKey {
        case title
        case facts = "rows"
    }
}

struct Fact: Codable {
    let title: String?
    let desc: String?
    let imageURLString: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case desc = "description"
        case imageURLString = "imageHref"
    }
}

// MARK: - UIViewController


class TableViewController: UITableViewController {
    
    fileprivate let requestHandler = RequestHandler()
    fileprivate var facts: [Fact] = []
    
    fileprivate let cellIdentifier = "factCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchCountryData()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        
        //Register TableView Cell
        tableView.estimatedRowHeight = 60
        tableView.register(FactCell.self, forCellReuseIdentifier: cellIdentifier)
        
        // Configure Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshCountryData(_:)), for: .valueChanged)
    }

    private func fetchCountryData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        requestHandler.requestCountryData { [weak self] (result, errorMessage) in
            self?.refreshControl?.endRefreshing()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let result = result {
                self?.title = result.title
                
                self?.facts = result.facts
                self?.tableView.reloadData()
                
            } else if let errorMessage = errorMessage {
                self?.showErrorAlert(errorMessage)
            }
        }
    }
    
    //refresh controller selector
    @objc private func refreshCountryData(_ sender: Any) {
        // Fetch Country Data
        fetchCountryData()
    }
 
    private func showErrorAlert(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Table view data source

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FactCell
        cell.configure(facts[indexPath.row])
        return cell
    }
}


