//
//  PersonListPageViewController.swift
//  IbanSaver
//
//  Created by Levan Loladze on 12.01.24.
//

import SwiftUI
import UIKit

class PersonListPageViewController: UIViewController {
    
    var persons: [PersonModel] = [
        PersonModel(fullName: "levaniko Dzlieri", avatarName: "male1", savedIbans: [], isMale: true),
        PersonModel(fullName: "giviko Lamazi", avatarName: "female3", savedIbans: [], isMale: false),
        PersonModel(fullName: "Jemal loladze", avatarName: "male3", savedIbans: [], isMale: true),
        PersonModel(fullName: "nataliko", avatarName: "female1", savedIbans: [], isMale: false),
        PersonModel(fullName: "John Doe", avatarName: "male3", savedIbans: [], isMale: true),
        PersonModel(fullName: "Jane Doe", avatarName: "female2", savedIbans: [], isMale: false),
    ]
    
    let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let addPersonButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Person", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupTableView()
        setupAddPersonButton()
    }
    
    private func setupBackground() {
        let backgroundImage = UIImageView(image: UIImage(named: "bg2"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.sendSubviewToBack(backgroundImage)
    }
    
    private func setupTableView() {
        view.addSubview(homeTableView)
        
        homeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        
        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            homeTableView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    private func setupAddPersonButton() {
        view.addSubview(addPersonButton)
        
        addPersonButton.applyAddButtonStyle()
        
        NSLayoutConstraint.activate([
            addPersonButton.topAnchor.constraint(equalTo: homeTableView.bottomAnchor, constant: 30),
            addPersonButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addPersonButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addPersonButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        addPersonButton.addAction(UIAction { _ in
            self.navigationController?.pushViewController(UIHostingController(rootView: PersonAddView(onSave: { newPerson in

                self.persons.append(newPerson)

                self.homeTableView.reloadData()
                
                self.navigationController?.popViewController(animated: true)
            })), animated: true)
        }, for: .touchUpInside)
    }
    
    
    
}

extension PersonListPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let person = persons[indexPath.row]
        
        cell.contentConfiguration = UIHostingConfiguration {
            VStack {
                ListRowView(image: person.avatarName, textLabel: person.fullName, personView: true)
            }
        }
        .background(.clear)
        
        return cell
    }
    
    
}

extension UIButton {
    func applyAddButtonStyle() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 50)
        self.setTitleColor(UIColor(AppColors.white), for: .normal)
        self.backgroundColor = UIColor(AppColors.white.opacity(0.04))
        self.layer.cornerRadius = 40
    }
}
