//
//  AccountInfoViewController.swift
//  TransitionDemo
//
//  Created by Alex on 23.11.2025.
//

import UIKit
import Kingfisher

class AccountInfoViewController: UIViewController {
    var profileId: String?
    private var data: ProfileCodable?
    private var accountService = DI.shared.accountRepository

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.backgroundColor = .tertiaryLabel
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }

    private func fetchData() {
        guard let profileId else { return }
        DispatchQueue.main.async {
            UiKit.shared.activityIndicator.startAnimating()
        }
        accountService.getProfile(profileId: profileId) { [weak self] (result: Result<ProfileCodable, Error>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                UiKit.shared.activityIndicator.stopAnimating()
            }

            switch result {
            case .success(let profileModel):
                self.data = profileModel
                DispatchQueue.main.async {
                    self.configure()
                }
            case .failure(let error):
                ErrorHandler.shared.show(error: error, on: self) { [weak self] in
                    self?.fetchData()
                }
            }
        }
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        view.addSubview(UiKit.shared.activityIndicator)
        scrollView.addSubview(contentView)

        contentView.addSubview(avatarImage)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(infoStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            avatarImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 120),
            avatarImage.heightAnchor.constraint(equalToConstant: 120),

            fullNameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 16),
            fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            usernameLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            infoStackView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 32),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            UiKit.shared.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            UiKit.shared.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configure() {
        guard let data = data else { return }

        // Аватар
        let placeholderImage = UIImage(systemName: "person.fill")
        if let imageUrl = data.imageUrl, let url = URL(string: imageUrl) {
            avatarImage.kf.setImage(
                with: url,
                placeholder: placeholderImage,
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]
            )
        } else {
            avatarImage.image = placeholderImage
        }

        // Полное имя
        let fullName = [data.firstName, data.lastName].compactMap { $0 }.joined(separator: " ")
        fullNameLabel.text = fullName

        // Username - ник
        if let username = data.username {
            usernameLabel.text = "@\(username)"
        }
        infoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        addInfoRow(icon: "phone.fill", title: "Телефон", value: data.phone)
        if let about = data.about, !about.isEmpty {
            addInfoRow(icon: "info.circle.fill", title: "О себе", value: about)
        }
        addInfoRow(icon: "globe", title: "Язык", value: data.langCode.uppercased())
        addInfoRow(icon: "number", title: "ID", value: String(data.id))
    }

    private func addInfoRow(icon: String, title: String, value: String) {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .secondaryLabel
        titleLabel.text = title

        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = .systemFont(ofSize: 16, weight: .regular)
        valueLabel.textColor = .label
        valueLabel.text = value
        valueLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4

        containerView.addSubview(iconImageView)
        containerView.addSubview(stackView)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            stackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        infoStackView.addArrangedSubview(containerView)
    }
}
