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
}

