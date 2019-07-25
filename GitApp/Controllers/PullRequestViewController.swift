//
//  PullRequestViewController.swift
//  GitApp
//
//  Created by Danilo Requena on 24/07/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit
import SafariServices

class PullRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var github: GithubData?
    let api = Interactor<[PullRequest]>()
    var pullRequests = [PullRequest]()
    lazy var urlString = ""
    let label: UILabel = {
        var lbl = UILabel()
        lbl = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        lbl.font = UIFont(name: "Avenir Next", size: 17)
        lbl.textColor = UIColor.black
        lbl.text = "Nenhum Pull Request, até o momento!"
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        if let githubData = github {
            navigationItem.title = githubData.owner.authorName
            guard let url = URL(string: "\(pullRequestUrl)\(githubData.owner.authorName)/\(githubData.name)/pulls") else { return }
            spinner.startAnimating()
            api.fetchModel(url: url, completion: { (pullRequest) in
                if let pullRequestData = pullRequest {
                    for data in pullRequestData {
                        self.pullRequests.append(data)
                    }
                }
                self.spinner.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
    
    func openSafari(with url: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true, completion: nil)
    }
}

extension PullRequestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        urlString = pullRequests[indexPath.row].user.htmlUrl
        guard let url = URL(string: urlString) else { return }
        openSafari(with: url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = pullRequests.count == 0 ? label : nil
        return pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: REQUEST_CELL, for: indexPath) as? PullRequestTableViewCell else { return UITableViewCell() }
        cell.configureCell(pullRequest: pullRequests[indexPath.row])
        
        return cell
    }
    

}
