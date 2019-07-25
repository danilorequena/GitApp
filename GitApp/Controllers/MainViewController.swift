//
//  ViewController.swift
//  GitApp
//
//  Created by Danilo Requena on 24/07/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let api = Interactor<Items>()
    var gitHubData = [GithubData]()
    var github: GithubData?
    var page = 1
    var isLoadingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        setupView(page)
    }

    func setupTable() {
        tableView.tableFooterView = UIView()
    }
    
    func setupView(_ page: Int) {
        guard let url = URL(string: "\(baseUrl)\(page)") else { return }
        isLoadingData = false
//        spinner.startAnimating()
        api.fetchModel(url: url) { (items) in
            if let itemsData = items {
                for data in itemsData.items {
                    self.gitHubData.append(data)
                }
            }
//            self.spinner.stopAnimating()
            self.tableView.reloadData()
        }
    }
    @IBAction func scrollToTop(_ sender: UIBarButtonItem) {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_TO_REQUEST {
            let requestVC = segue.destination as! PullRequestViewController
            requestVC.github = sender as? GithubData
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        github = gitHubData[indexPath.row]
        performSegue(withIdentifier: SEGUE_TO_REQUEST, sender: github)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitHubData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GITHUB_CELL, for: indexPath) as? GithubCell else { return UITableViewCell() }
        cell.configureCell(data: gitHubData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == gitHubData.count - 5 && !isLoadingData {
            isLoadingData = true
            page += 1
            setupView(page)
        }
    }
}
