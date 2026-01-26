//
//  AccountsViewController.swift
//  TransitionDemo
//
//  Created by Alex Riman on 24.04.2025.
//

import UIKit

class AccountsViewController: UIViewController {

    private var data: [AccountModel] = []
    private var accountService = DI.shared.accountRepository
    
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
        setupRefreshButton()
        fetchData()
    }

    private func setupRefreshButton() {
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshButtonTapped)
        )
        navigationItem.rightBarButtonItem = refreshButton
    }

    @objc private func refreshButtonTapped() {
        fetchData()
    }
    
    private func fetchData() {
        DispatchQueue.main.async {
            UiKit.shared.activityIndicator.startAnimating()
        }

        accountService.getAllAccounts { [weak self] (result: Result<[AccountInfoItem], Error>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                UiKit.shared.activityIndicator.stopAnimating()
            }

            switch result {
            case .success(let accounts):
                self.data = accounts.map { item in
                    item.mapToAccountModel()
                }
                DispatchQueue.main.async {
                    self.accountsView.reloadData()
                }
            case .failure(let error):
                ErrorHandler.shared.show(error: error, on: self) { [weak self] in
                    self?.fetchData()
                }
            }
        }
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(accountsView)
        view.addSubview(UiKit.shared.activityIndicator)

        NSLayoutConstraint.activate([
            accountsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            UiKit.shared.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            UiKit.shared.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        
        cell.configure(iconUrl: model.urlToImage, title: model.title, description: model.subtitle)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = AccountInfoViewController()
        viewController.profileId = data[indexPath.row].id
        navigationController?.pushViewController(viewController, animated: true)
    }
}
