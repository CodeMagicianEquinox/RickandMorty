import Foundation

class RMAPIService {

    private let baseUrlString: String = "https://rickandmortyapi.com/api"

    // Builds: https://rickandmortyapi.com/api/character?page=1&name=rick
    private func buildUrl(page: Int, name: String?) -> URL? {

        let fullString: String = baseUrlString + "/character"

        let componentsOptional: URLComponents? = URLComponents(string: fullString)
        if componentsOptional == nil {
            return nil
        }

        var components: URLComponents = componentsOptional!

        var items: [URLQueryItem] = []
        items.append(URLQueryItem(name: "page", value: String(page)))

        if let nameValue: String = name {
            if nameValue.isEmpty == false {
                items.append(URLQueryItem(name: "name", value: nameValue))
            }
        }

        components.queryItems = items
        return components.url
    }

    func fetchCharacters(page: Int, name: String?) async throws -> CharacterResponse {

        let urlOptional: URL? = buildUrl(page: page, name: name)
        if urlOptional == nil {
            throw RMAPIError.invalidUrl
        }

        let url: URL = urlOptional!

        let dataAndResponse: (Data, URLResponse)

        do {
            dataAndResponse = try await URLSession.shared.data(from: url)
        } catch {
            throw RMAPIError.requestFailed
        }

        let data: Data = dataAndResponse.0
        let response: URLResponse = dataAndResponse.1

        let httpOptional: HTTPURLResponse? = response as? HTTPURLResponse
        if httpOptional == nil {
            throw RMAPIError.invalidResponse
        }

        let http: HTTPURLResponse = httpOptional!

        if http.statusCode == 200 {
            // Success. Keep going to decode the data.
        } else if http.statusCode == 404 {
            throw RMAPIError.noResults
        } else {
            throw RMAPIError.badStatusCode(http.statusCode)
        }

        do {
            let decoder: JSONDecoder = JSONDecoder()
            return try decoder.decode(CharacterResponse.self, from: data)
        } catch {
            throw RMAPIError.decodingFailed
        }
    }
}
