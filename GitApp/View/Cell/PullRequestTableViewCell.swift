//
//  PullRequestTableViewCell.swift
//  GitApp
//
//  Created by Danilo Requena on 24/07/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import Foundation
import SDWebImage

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    
    func configureCell(pullRequest: PullRequest) {
        
        let date = pullRequest.date.split(separator: "T")
        let dateData = date[0].split(separator: "-")
        let day = dateData[2]
        let month = dateData[1]
        let year = dateData[0]
        
        guard let url = URL(string: pullRequest.user.userImage) else { return }
        DispatchQueue.main.async {
            self.imgBackground.sd_setImage(with: url, completed: nil)
            self.imageUser.sd_setImage(with: url, completed: nil)
            self.lblUserName.text = pullRequest.user.userName
            self.lblTitle.text = pullRequest.title
            self.lblDate.text = "\(day)/\(month)/\(year)"
            self.txtDescription.text = pullRequest.description
        }
    }

}
