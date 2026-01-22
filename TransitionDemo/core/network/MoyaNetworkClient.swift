import Foundation
import Moya

class MoyaNetworkClient {
    
    private let jsonDecoder = JSONDecoder()
    
    private lazy var provider = MoyaProvider<MoyaNetwork>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    
    func request <T : Codable> (request: MoyaNetwork, completion: @escaping (Result<T, any Error>) -> Void) {
        provider.request(request) { result in
            switch result {
            case .success(let response):
                let data = response.data
                if let accountsResponse = try? self.jsonDecoder.decode(T.self, from: data) {
                    completion(.success(accountsResponse))
                }
            case .failure(let error):
                print(error.errorDescription ?? "Unknown error")
                completion(.failure(error))
            }
        }
        
    }
    
}
