//
//  PurpleViewController.swift
//  TransitionDemo
//
//  Created by Timur Saidov on 24.04.2025.
//

import UIKit

class PurpleViewController: UIViewController {

    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .add)
        button.action = #selector(didTapAddButton)
        button.target = self
        return button
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var value: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = .purple
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func didTapAddButton() {
        let blueVC = BlueViewController()
        blueVC.modalPresentationStyle = .fullScreen
        present(blueVC, animated: true)
    }

    @objc private func didTapButton() {
        let brownVC = BrownViewController()
        brownVC.delegate = self
        let navVC = UINavigationController(
            rootViewController: brownVC
        )
        present(navVC, animated: true)
    }
}
