//
//  UserDetailViewModel.swift
//  DemoApp
//
//  Created by Mangesh Vyas on 26/08/22.
//

import Foundation

class UserDetailViewModel {
    var userMadel: UserModel? {
        didSet {
            self.bindUserViewModelToController()
        }
    }
    var bindUserViewModelToController : (() -> ()) = {}
    
    init(login: String) {
        self.getUserDetail(user: login)
    }
    
    func getUserDetail(user: String) {
        WebAPIManager.shared.callWebService(serviceName: "\(WS_USERS)/\(user)", method: .get, parameter: [String : Any]()) { data in
            do {
                let jsonDecoder = JSONDecoder()
                let userDetail = try jsonDecoder.decode(UserModel.self, from: data)
                self.userMadel = userDetail
            } catch {
                print("Error while decoding response: \(String(data: data, encoding: .utf8) ?? "")")
            }
        } failure: { error in
        }
    }
}
