import Foundation
import Moya

class MoyaNetworkClient {

    private let jsonDecoder = JSONDecoder()

    private lazy var provider = MoyaProvider<MoyaNetwork>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])


    func request <T : Codable> (request: MoyaNetwork, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(request) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.handleSuccessResponse(response, completion: completion)

            case .failure(let error):
                self.handleNetworkFailure(error, completion: completion)
            }
        }
    }

    // MARK: - Private Methods

    private func handleSuccessResponse<T: Codable>(_ response: Response, completion: @escaping (Result<T, Error>) -> Void) {
        if let error = validateStatusCode(response.statusCode) {
            completion(.failure(error))
            return
        }
        if let error = validateResponseData(response.data) {
            completion(.failure(error))
            return
        }
        decodeResponse(response.data, completion: completion)
    }

    private func validateStatusCode(_ statusCode: Int) -> NetworkError? {
        guard (200...299).contains(statusCode) else {
            let error = NetworkError.serverError(statusCode: statusCode)
            print("Server error: \(error.errorDescription ?? "")")
            return error
        }
        return nil
    }

    private func validateResponseData(_ data: Data) -> NetworkError? {
        guard !data.isEmpty else {
            let error = NetworkError.noData
            print("No data received")
            return error
        }
        return nil
    }

    private func decodeResponse<T: Codable>(_ data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let decodedResponse = try jsonDecoder.decode(T.self, from: data)
            completion(.success(decodedResponse))
        } catch {
            print("Decoding error: \(error)")
            completion(.failure(NetworkError.decodingError))
        }
    }

    private func handleNetworkFailure<T>(_ error: MoyaError, completion: @escaping (Result<T, Error>) -> Void) {
        print("Network error: \(error.localizedDescription)")
        let networkError = NetworkError.networkError(error)
        completion(.failure(networkError))
    }
}
