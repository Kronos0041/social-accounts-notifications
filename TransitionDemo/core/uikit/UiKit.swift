//
//  DI.swift
//  TestNetworkOtus
//
//  Created by Anna Zharkova on 16.01.2026.
//

import UIKit

class UiKit {
    
    static let shared = UiKit()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .gray
        return indicator
    }()
}
