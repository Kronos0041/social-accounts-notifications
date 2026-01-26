//
//  AccountsInfo.swift
//  TransitionDemo
//
//  Created by Alex on 17.01.2026.
//


import Foundation


struct AccountInfoItem : Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    var urlToImage: String
    var nickname: String
    var phone: String?
}

extension AccountInfoItem {
    func mapToAccountModel () -> AccountModel {
        .init(
            id: id,
            urlToImage: urlToImage,
            title: nickname,
            subtitle: phone,
        )
    }
}
