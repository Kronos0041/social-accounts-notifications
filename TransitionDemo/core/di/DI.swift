//
//  DI.swift
//  TestNetworkOtus
//
//  Created by Anna Zharkova on 16.01.2026.
//

import Foundation

class DI {
    
    static let shared = DI()
    
    lazy var moyaNetworkClient: MoyaNetworkClient = {
        return MoyaNetworkClient()
    }()
    
    lazy var accountRepository: AccountsRepository = {
     return AccountsRepository()
    }()
    
}
