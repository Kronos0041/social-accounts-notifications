//
//  ImageExtension.swift
//  TransitionDemo
//
//  Created by Alex on 22.01.2026.
//

import UIKit

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.layer.masksToBounds = true
    }
}
