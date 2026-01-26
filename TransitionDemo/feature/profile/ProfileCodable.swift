//
//  Profile.swift
//  TransitionDemo
//
//  Created by Alex on 26.01.2026.
//

struct ProfileCodable: Codable {
    let id: Int
    let firstName: String
    let lastName: String?
    let username: String?
    let phone: String
    let about: String?
    let imageUrl: String?
    let langCode: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case imageUrl = "image"
        case username
        case phone
        case about
        case langCode = "lang_code"
    }
}
