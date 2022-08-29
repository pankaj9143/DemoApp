//
//  UserListViewModel.swift
//  DemoApp
//
//  Created by Mangesh Vyas on 26/08/22.
//

import Foundation

class UserListViewModel {
    var arrSearchUserList = [UserModel]() {
        didSet {
            self.bindUserViewModelToController()
        }
    }
    var bindUserViewModelToController : (() -> ()) = {}
    
    var arrUserList = [UserModel]()
    
    init() {
    }
    
    func getUserList() {
        WebAPIManager.shared.callWebService(serviceName: WS_USERS, method: .get, parameter: [String : Any]()) { data in
            do {
                let jsonDecoder = JSONDecoder()
                let userList = try jsonDecoder.decode([UserModel].self, from: data)
                self.arrUserList = userList
                self.arrSearchUserList = userList
            } catch {
                print("Error while decoding response: \(String(data: data, encoding: .utf8) ?? "")")
            }
        } failure: { error in
        }
    }
}
