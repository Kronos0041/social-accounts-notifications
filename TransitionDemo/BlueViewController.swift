//
//  BlueViewController.swift
//  TransitionDemo
//
//  Created by Timur Saidov on 24.04.2025.
//

import UIKit

class BlueViewController: UIViewController {

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 100),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor, multiplier: 1.0)
        ])
    }

    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }
}
