//
//  AutoLayoutViewController.swift
//  TransitionDemo
//
//  Created by Alex on 23.11.2025.
//
// Добавить 2 UILabel на экран с равными отступами горизонтально
// Задать у 1го приоритет растяжения выше, чем у второго (протестировать в последствии, что контент внутри лейблов так и работает)
// Добавить UIImageView с отступом от центра на 1/10 экрана вверх но не более чем на 10 pt удаленно от label снизу
// Реализовать возможность переворота экрана, при перевороте выстроить все три view (2 label и UIImageView) горизонтально равноудаленно друг от друга и по 20 pt от краев superview

import UIKit

class AutoLayoutViewController: UIViewController {

    private var imageViewCenterYConstraint: NSLayoutConstraint?
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []

    private lazy var label1: UILabel = {
        let label = UILabel()
        label.text = "Label1Label1Label1Label1Label1Label1Label1Label1Label1Label1Label1Label1"
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var label2: UILabel = {
        let label = UILabel()
        label.text = "Label2Label2Label2Label2Label2Label2Label2Label2Label2Label2Label2Label2"
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "telegramIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(imageView)

        label2.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        setupPortraitConstraints()
        setupLandscapeConstraints()
        updateConstraintsForOrientation()
    }

    private func setupPortraitConstraints() {
        // Лейблы горизонтально по центру экрана
        portraitConstraints = [
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label1.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            label2.leadingAnchor.constraint(equalTo: label1.trailingAnchor, constant: 20),
            label2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label2.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),

            // imageView: размеры + центр по X
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ]

        // Не выше, чем на 10pt от label1 снизу
        let maxTopConstraint = imageView.topAnchor.constraint(greaterThanOrEqualTo: label1.bottomAnchor, constant: 10)
        maxTopConstraint.priority = .required
        portraitConstraints.append(maxTopConstraint)

        // Центр по Y со смещением на 1/10 вверх
        let centerYConstraint = imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerYConstraint.priority = .defaultHigh
        portraitConstraints.append(centerYConstraint)
        imageViewCenterYConstraint = centerYConstraint
    }

    private func setupLandscapeConstraints() {
        // В альбомной ориентации: label1, imageView, label2 горизонтально с равными отступами
        landscapeConstraints = [
            label1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label1.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            imageView.leadingAnchor.constraint(equalTo: label1.trailingAnchor, constant: 20),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            label2.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            label2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            // Равная ширина для лейблов
            label1.widthAnchor.constraint(equalTo: label2.widthAnchor)
        ]
    }

    private func updateConstraintsForOrientation() {
        if UIDevice.current.orientation.isLandscape || view.bounds.width > view.bounds.height {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        } else {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateConstraintsForOrientation()

        // Смещение imageView на 1/10 вверх в портретной ориентации
        if portraitConstraints.first?.isActive == true {
            let offset = view.bounds.height * 0.1
            imageViewCenterYConstraint?.constant = -offset
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.updateConstraintsForOrientation()
        })
    }
}

