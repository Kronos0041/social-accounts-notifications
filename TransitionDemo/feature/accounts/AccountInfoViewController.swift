//
//  AccountInfoViewController.swift
//  TransitionDemo
//
//  Created by Alex on 23.11.2025.
//

import UIKit

class AccountInfoViewController: UIViewController {
    
    var accountName = "not found error!"
    var accountDescription = "not found error!"

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private func setup() {
        avatarImage.layer.cornerRadius = 40
        cameraButton.layer.cornerRadius = 40
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCameraButton))
        cameraButton.addGestureRecognizer(tapGesture)
    }

    
    @objc func didTapCameraButton() {
        let aletController = UIAlertController(title: "Сфотографировать", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                self?.present(imagePicker, animated: true)
            }
        }
        let galleryAction = UIAlertAction(title: "Галерея", style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                self?.present(imagePicker, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        aletController.addAction(cameraAction)
        aletController.addAction(galleryAction)
        aletController.addAction(cancelAction)
        present(aletController, animated: true)
    }
    
    private func showAlertIsCopied() {
        let alertController = UIAlertController(title: "Скопировано!", message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            alertController.dismiss(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accountNameLabel.text = accountName
        self.descriptionLabel.text = accountDescription
        setup()
    }
}

extension AccountInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectImage = info[.originalImage] as? UIImage
        avatarImage.image = selectImage
        dismiss(animated: true)
    }
}
