//
//  UserTableViewCell.swift
//  DemoApp
//
//  Created by Mangesh Vyas on 26/08/22.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    @IBOutlet private weak var imgUser: UIImageView!
    @IBOutlet private weak var lblUserName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(user: UserModel) {
        let imageUrl = URL(string: user.avatarUrl)
        imgUser.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(named: "placeHolder.png"),
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ],
            progressBlock: { receivedSize, totalSize in
            },
            completionHandler: { result in
            }
        )
        lblUserName.text = user.login.capitalized
        if CommonUtility.getUserFromPreference(key: "\(user.userId)") {
            backgroundColor = .lightGray
        } else {
            backgroundColor = .white
        }
    }
}
