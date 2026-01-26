//
//  NetworkError.swift
//  TransitionDemo
//
//  Created by Alex on 26.01.2026.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int)
    case networkError(Error)
    case noData
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Некорректный ответ от сервера"
        case .decodingError:
            return "Ошибка обработки данных"
        case .serverError(let statusCode):
            return "Ошибка сервера (код: \(statusCode))"
        case .networkError(let error):
            return "Ошибка сети: \(error.localizedDescription)"
        case .noData:
            return "Нет данных от сервера"
        case .unknown:
            return "Неизвестная ошибка"
        }
    }

    var userFriendlyMessage: String {
        switch self {
        case .invalidResponse, .decodingError, .noData:
            return "Не удалось обработать данные. Попробуйте позже."
        case .serverError(let statusCode):
            if statusCode >= 500 {
                return "Проблемы на сервере. Попробуйте позже."
            } else if statusCode == 404 {
                return "Запрашиваемые данные не найдены"
            } else if statusCode == 401 || statusCode == 403 {
                return "Нет доступа к данным"
            } else {
                return "Ошибка при загрузке данных (код: \(statusCode))"
            }
        case .networkError:
            return "Проверьте подключение к интернету"
        case .unknown:
            return "Что-то пошло не так. Попробуйте еще раз."
        }
    }
}
