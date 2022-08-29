//
//  UserListViewController.swift
//  DemoApp
//
//  Created by Mangesh Vyas on 26/08/22.
//

import UIKit
import Kingfisher

class UserListViewController: UIViewController {
    
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet private weak var tblUserList: UITableView!
    private let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ "
    var viewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblUserList.reloadData()
    }
    
    private func setup() {
        viewModel.getUserList()
        self.viewModel.bindUserViewModelToController = {
            self.tblUserList.reloadData()
        }
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .white
        }
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrSearchUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.setData(user: viewModel.arrSearchUserList[indexPath.row])
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblUserList.deselectRow(at: indexPath, animated: true)
        let user = viewModel.arrSearchUserList[indexPath.row]
        CommonUtility.setUserInPreference(key: "\(user.userId)")
        let vm = UserDetailViewModel(login: user.login)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        vc.viewModel = vm
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension UserListViewController: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filtered = text.components(separatedBy: cs).joined(separator: "")
        return (text == filtered)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchUser(search: searchBar.text!.count > 0)
    }
    
    private func searchUser(search: Bool) {
        if search {
            let searchedData = viewModel.arrUserList.filter({ $0.login.localizedCaseInsensitiveContains(self.searchBar.text!)})
            viewModel.arrSearchUserList = searchedData
        } else {
            viewModel.arrSearchUserList = viewModel.arrUserList
        }
    }
}


