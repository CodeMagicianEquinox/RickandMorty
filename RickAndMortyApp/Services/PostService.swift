import Foundation

class PostService {
    private let endpoint = "https://jsonplaceholder.typicode.com/posts"

    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: endpoint) else {
            throw PostAPIError.invalidURL
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw PostAPIError.requestFailed
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw PostAPIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw PostAPIError.badStatusCode(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode([Post].self, from: data)
        } catch {
            throw PostAPIError.decodingFailed
        }
    }
}
