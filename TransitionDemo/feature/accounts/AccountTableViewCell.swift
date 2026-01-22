//
//  CustomTableViewCell.swift
//  TransitionDemo
//
//  Created by Alex on 23.11.2025.
//


import UIKit
import Kingfisher


class AccountTableViewCell: UITableViewCell {
    static let identifier = "AccountTableViewCell"

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.frame.size = CGSize(width: 40, height: 40)
        iconImageView.setRounded()
        return iconImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 1

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 2

        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.tintColor = .systemGray

        let textStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        textStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(iconImageView)
        contentView.addSubview(textStack)
        contentView.addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),

            textStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            textStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -12),

            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(
        iconUrl: String,
        title: String,
        description: String?
    ) {
        iconImageView.kf.setImage(with: URL(string: iconUrl))
        titleLabel.text = title
        if let safeDescription = description {
            descriptionLabel.text = safeDescription
        }
    }
}
