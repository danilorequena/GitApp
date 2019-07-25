//
//  GithubCell.swift
//  GitApp
//
//  Created by Danilo Requena on 24/07/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import UIKit
import SDWebImage

class GithubCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: BackgroundView!
    @IBOutlet weak var imageOwner: CustomUIImageView!
    @IBOutlet weak var lblOwnerName: UILabel!
    @IBOutlet weak var lblRepoName: UILabel!
    @IBOutlet weak var lblStars: UILabel!
    @IBOutlet weak var lblForks: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    func configureCell (data: GithubData) {
        guard let url = URL(string: data.owner.avatarUrl) else { return }
        DispatchQueue.main.async {
            self.imageOwner.sd_setImage(with: url, completed: nil)
            self.lblOwnerName.text = data.owner.authorName
            self.lblRepoName.text = data.name
            self.lblStars.text = "\(data.stars)"
            self.lblForks.text = "\(data.forks)"
            self.lblDescription.text = data.description
        }
    }

}
