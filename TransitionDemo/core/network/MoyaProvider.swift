//
//  MoyaProvider.swift
//  TestNetworkOtus
//
//  Created by Anna Zharkova on 16.01.2026.
//

import Foundation
import Moya
import Alamofire

enum MoyaNetwork {
    case getAllAccounts(userId: String)
}

extension MoyaNetwork: TargetType {
    
    
    var baseURL: URL { return URL(string: "https://my-json-server.typicode.com/Kronos0041/otus-demo")! }
    
    var path: String {
        switch self {
        case .getAllAccounts(let userId):
            return "/accounts"
        }
    }
    
    var method: Moya.Method {
       return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getAllAccounts(let userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}
