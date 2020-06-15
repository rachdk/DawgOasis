//
//  CourseLookupController.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 6/1/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import Foundation
import UIKit


protocol CourseLookupControllerDelegate: class {
    func controller (_ controller: CourseLookupController, wantsToLookUpCourses user: User)
}

class CourseLookupController: UIViewController {
     //Mark - Properties
    
   // private var user: User
    weak var delegate: CourseLookupControllerDelegate?
    var course: String?
    
    private let coursePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Look up the student list", for: .normal)
        button.layer.cornerRadius = 5
         button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        button.setHeight(height: 50)
        button.tintColor = .white
        
        
        button.addTarget(self, action: #selector(showList), for: .touchUpInside)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add me into the list", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setHeight(height: 50)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addCourse), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showList() {
        let controller = StudentListController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)	
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func showChatController(forUser user: User)
    {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func addCourse() {
//        Service.uploadCourse([(course!)]) { error in
//            if error != nil {
//                print("DEBUG")
//            }
//        }
    }
    //Mark - LifeCycle
    
    let pickerStyle: [String] = ["148", "149" , "342", "343" , "430", "434"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.view.addSubview(coursePicker)
        coursePicker.delegate = self as UIPickerViewDelegate
        coursePicker.dataSource = self as UIPickerViewDataSource
        
        coursePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        coursePicker.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 220.0).isActive = true
        coursePicker.center = view.center
        
        self.view.addSubview(selectButton)
        selectButton.anchor(top: coursePicker.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20)
        selectButton.center = view.center
        
        self.view.addSubview(addButton)
        addButton.anchor(top: selectButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20)
        addButton.center = view.center
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar(withTitle: "Courses", prefersLargeTitles: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(handleDismissal))
    }
}

extension CourseLookupController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView (_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 1
        } else {
            return pickerStyle.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "CSS"
        }
        else {
            return pickerStyle[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        course = "CSS\(pickerStyle[row])"
    }
    
}

extension CourseLookupController: UIPickerViewDelegate {
    
}

extension CourseLookupController: StudentListControllerDelegate {
    func controller(_ controller: StudentListController, wantsToSeeList user: User) {
        controller.dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
    }
}

