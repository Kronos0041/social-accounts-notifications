//
//  AccountRepository.swift
//  TransitionDemo
//
//  Created by Alex on 26.12.2025.
//

import Foundation
import Moya

final class AccountsRepository {
    private let moyaNetworkClient = MoyaNetworkClient()
    
    func getAllAccounts(completion: @escaping (Result<[AccountInfoItem], Error>) -> Void) {
        moyaNetworkClient.request(request: .getAllAccounts(userId: "test-user-id")) { (result: Result<[AccountInfoItem], Error>) in
            completion(result)
        }
    }
    
    func getProfile(
        profileId: String,
        completion: @escaping (Result<ProfileCodable, Error>) -> Void
    ) {
        moyaNetworkClient.request(request: .getProfile(profileId: profileId)) { (result: Result<ProfileCodable, Error>) in
            completion(result)
        }
    }
}

