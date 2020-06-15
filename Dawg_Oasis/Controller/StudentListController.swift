//
//  StudentListController.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 6/14/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "UserCell"

protocol StudentListControllerDelegate: class {
    func controller (_ controller: StudentListController, wantsToSeeList user: User)
}

class StudentListController: UITableViewController{
    
    //Mark - Properties
    
    private var users = [User]()
    weak var delegate: StudentListControllerDelegate?
    
    
    //Mark - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    
    //MARK - Selector
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //Mark - API
    
    func fetchUsers() {
        Service.fetchUsers() { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //Mark - Helpers
    func configureUI() {
        configureNavigationBar(withTitle: "Student List", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
}

extension StudentListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
}

extension StudentListController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG \(users[indexPath.row].username)")
        delegate?.controller(self, wantsToSeeList: users[indexPath.row])
    }
}


//extension StudentListController{
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("DEBUG \(users[indexPath.row].username)")
//        delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
//    }
//}
