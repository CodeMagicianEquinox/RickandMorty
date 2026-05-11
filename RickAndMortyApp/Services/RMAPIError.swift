// Errors for the API layer.
enum RMAPIError: Error, Equatable {
    case invalidUrl
    case requestFailed
    case invalidResponse
    case badStatusCode(Int)
    case noResults
    case decodingFailed
}
