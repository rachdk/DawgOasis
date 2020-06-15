//
//  ConversationsController.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/25/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import Foundation
import UIKit
import Firebase

private let reuseIdentifier = "ConversationCell"

class ConversationsController: UIViewController {
    //Mark Properties
    
    //private var user: User
    private let tableView = UITableView()
    private var conversations = [Conversation]()
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.addTarget(self, action: #selector(updateCourse), for: .touchUpInside)
        return button
    }()
    
//    private let courseButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
//        button.tintColor = .black
//        button.addTarget(self, action: #selector(updateCourse), for: .touchUpInside)
//        return button
//    }()
    
    //Mark Lifecycle
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
        fetchConversations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "Friends", prefersLargeTitles: true)
    }
    
    //Mark Selector
    
    @objc func showProfile() {
        logout()
    }
    
    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func updateCourse() {
        
        let controller = CourseLookupController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: true, completion: nil)
        
    }
    
    //Mark - API
    
    func fetchConversations() {
        Service.fetchConversations {conversations in
            self.conversations = conversations
            self.tableView.reloadData()
        }
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        }
        else {
            print("DEBUG")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
                presentLoginScreen()
        } catch {
            print("DEBUG")
        }
    }
    //Mark Helper
    
    func presentLoginScreen() {
        DispatchQueue.main.async{
            let controller = LogInController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    func configureUI() {
        view.backgroundColor = .white
        
        configureNavigationBar(withTitle: "Friends", prefersLargeTitles: true)
        configureTableView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Friends"
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(height: 56, width: 70)
        newMessageButton.layer.cornerRadius = 56 / 2
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right:
            view.rightAnchor, paddingBottom: 16, paddingRight: 24)
//        
//        view.addSubview(courseButton)
//        courseButton.anchor(left:
//            view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 16, paddingRight: 24)
//        
//        
    }
    
    func configureTableView()
    {
        //tableView.backgroundColor = .systemPink
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    func showChatController(forUser user: User)
    {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showCourseLookUp()
    {
        let controller = CourseLookupController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ConversationsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    
    
}

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)
    }
}

//MARK - NewMessageControllerDelegate

extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
    }
}

extension ConversationsController: CourseLookupControllerDelegate {
    func controller(_ controller: CourseLookupController, wantsToLookUpCourses user: User) {
        controller.dismiss(animated: true, completion: nil)
        showCourseLookUp()
    }
}

extension ConversationsController: StudentListControllerDelegate {
    func controller(_ controller: StudentListController, wantsToSeeList user: User) {
        controller.dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
    }
    
}
