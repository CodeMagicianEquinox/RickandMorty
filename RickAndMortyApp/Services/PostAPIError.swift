import Foundation

enum PostAPIError: Error, Equatable {
    case invalidURL
    case requestFailed
    case invalidResponse
    case badStatusCode(Int)
    case decodingFailed

    var message: String {
        switch self {
        case .invalidURL:
            return "The API URL is not valid."
        case .requestFailed:
            return "The request failed. Check your internet connection."
        case .invalidResponse:
            return "The server returned an invalid response."
        case .badStatusCode(let code):
            return "The server returned status code \(code)."
        case .decodingFailed:
            return "The app could not read the post data."
        }
    }
}
