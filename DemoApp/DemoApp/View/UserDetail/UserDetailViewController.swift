//
//  UserDetailViewController.swift
//  DemoApp
//
//  Created by Mangesh Vyas on 26/08/22.
//

import UIKit
import Kingfisher

class UserDetailViewController: UIViewController {
    @IBOutlet private weak var imgUser: UIImageView!
    @IBOutlet private weak var lblUserName: UILabel!
    @IBOutlet private weak var lblLocation: UILabel!
    @IBOutlet private weak var lblFollower: UILabel!
    @IBOutlet private weak var lblFollowing: UILabel!
    @IBOutlet private weak var lblCompany: UILabel!
    @IBOutlet private weak var lblEmail: UILabel!
    
    var viewModel: UserDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.bindUserViewModelToController = {
            if let detail = self.viewModel.userMadel {
                self.title = detail.login
                CommonUtility.setImage(imageView: self.imgUser, url: detail.avatarUrl)
                self.lblUserName.text = detail.name
                self.lblLocation.text = detail.location
                self.lblFollower.text = "\(detail.followers ?? 0)"
                self.lblFollowing.text = "\(detail.following ?? 0)"
                self.lblCompany.text = detail.company ?? ""
                self.lblEmail.text = detail.email ?? ""
            }
        }
    }
}
