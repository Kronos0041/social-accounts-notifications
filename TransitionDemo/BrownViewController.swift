//
//  BrownViewController.swift
//  TransitionDemo
//
//  Created by Timur Saidov on 24.04.2025.
//

import UIKit

class BrownViewController: UIViewController {

    weak var delegate: UIViewController?

    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .cancel)
        button.action = #selector(didTapCancelButton)
        button.target = self
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = cancelButton
        view.backgroundColor = .systemBrown
    }

    @objc private func didTapCancelButton() {
        (delegate as? PurpleViewController)?.value = 12
        dismiss(animated: true)
    }
}
