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
import Alamofire

class PinPhonesViewController: UIViewController {

    private var imageViewCenterYConstraint: NSLayoutConstraint?
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    
    private var phoneIsValid: Bool? = nil

    private lazy var phone: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nickname: UILabel = {
        let label = UILabel()
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
      
    }

    private func setupPortraitConstraints() {
        
    }

    private func setupLandscapeConstraints() {
        
    }
}

