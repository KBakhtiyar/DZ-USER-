//  ViewController.swift
//  PRAKTIKA BAZA D
//  Created by BK on 18.03.2024.

import UIKit
import RealmSwift
import SnapKit

class RealmVc: UIViewController {
    
   let realm = try! Realm()
    
    var user = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var textFieldName: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "NAME:"
        return textfield
    }()
    
    lazy var textFieldSurname: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "SURNAME:"
        return textfield
    }()
    
    lazy var textFieldPassword: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "PASSWORD:"
        return textfield
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("*TAP ME*", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(setName), for: .touchDragInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    private func setupViews() {
        view.addSubview(textFieldName)
        view.addSubview(textFieldSurname)
        view.addSubview(textFieldPassword)
        view.addSubview(button)
        view.addSubview(tableView)
        view.backgroundColor = .white
       textFieldName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        textFieldSurname.snp.makeConstraints { make in
           make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(textFieldName.snp.bottom).offset(8)
        }
        
        textFieldPassword.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(textFieldSurname.snp.bottom).offset(12)
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldSurname.snp.bottom).offset(40)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(button.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
   @objc func buttonTapped() {
    
        let user = User()
        user.name = textFieldName.text ?? ""
        textFieldName.text = ""
        user.surname = textFieldSurname.text ?? ""
        textFieldSurname.text = ""
        user.password = textFieldPassword.text ?? ""
        textFieldPassword.text = ""
       
        try! realm.write {
            realm.add(user)
        }
        getUser()
    }

    @objc func setName() {
        getUser()
    }
    
    private func getUser() {
        let user = realm.objects(User.self)
       
        self .user = user.map({ user in
            user
        })
    }
    
    
    private func updateUserName(to name: String, at index: Int) {
        
       let user = realm.objects(User.self)[index]
        
       try! realm.write({
            user.name = name
        })
   }
}

extension RealmVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = user[indexPath.row].name + user[indexPath.row].surname + user[indexPath.row].password
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, completionHandler) in
            
            self?.editUser(at: indexPath)
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    private func editUser(at indexPath: IndexPath) {
        updateUserName(to: textFieldSurname.text ?? "", at: indexPath.row)
        textFieldSurname.text = ""
        getUser()
        
    }    
}
