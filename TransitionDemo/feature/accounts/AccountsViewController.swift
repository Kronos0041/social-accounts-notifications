//
//  RedViewController.swift
//  TransitionDemo
//
//  Created by Timur Saidov on 24.04.2025.
//

import UIKit

class AccountsViewController: UIViewController {

    private let data: [AccountModel] = MockData.shared.accounts
    
    private lazy var accountsView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(accountsView)
        NSLayoutConstraint.activate([
            accountsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension AccountsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier, for: indexPath) as! AccountTableViewCell
        let model = data[indexPath.row]
        cell.configure(icon: UIImage(named: model.iconName), title: model.title, description: model.subtitle)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "AccountInfo", bundle: nil)
        let viewController = storyboard.instantiateViewController(
              withIdentifier: "AccountInfoViewController"
          ) as! AccountInfoViewController
        viewController.accountName = data[indexPath.row].title
        viewController.accountDescription = data[indexPath.row].subtitle
        navigationController?.pushViewController(viewController, animated: true)
    }
}
