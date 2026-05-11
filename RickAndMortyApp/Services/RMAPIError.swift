import Foundation

// Errors for the API layer.
enum RMAPIError: Error,Equatable {
    case invalidUrl
    case requestFailed
    case invalidResponse
    case badStatusCode(Int)
    case noResults
    case decodingFailed
}

class RMAPIService {

    private let baseUrlString: String = "https://rickandmortyapi.com/api"

    // Builds: https://rickandmortyapi.com/api/<path>?page=1&name=rick
    
    private func buildUrl(path: String, page: Int, name: String?) -> URL? {

        let fullString: String = baseUrlString + "/" + path

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

    // MARK: - CHARACTERS
    func fetchCharacters(page: Int, name: String?) async throws -> CharacterResponse {

        let urlOptional: URL? = buildUrl(path: "character", page: page, name: name)
        if urlOptional == nil { throw RMAPIError.invalidUrl }

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
        if httpOptional == nil { throw RMAPIError.invalidResponse }

        let http: HTTPURLResponse = httpOptional!
        let code: Int = http.statusCode

        if code == 200 {
            // OK
        } else if code == 404 {
            throw RMAPIError.noResults
        } else {
            throw RMAPIError.badStatusCode(code)
        }

        let decoder: JSONDecoder = JSONDecoder()
        do {
            let decoded: CharacterResponse = try decoder.decode(CharacterResponse.self, from: data)
            return decoded
        } catch {
            throw RMAPIError.decodingFailed
        }
    }

    // MARK: - EPISODES
    func fetchEpisodes(page: Int, name: String?) async throws -> EpisodeResponse {

        let urlOptional: URL? = buildUrl(path: "episode", page: page, name: name)
        if urlOptional == nil { throw RMAPIError.invalidUrl }

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
        if httpOptional == nil { throw RMAPIError.invalidResponse }

        let http: HTTPURLResponse = httpOptional!
        let code: Int = http.statusCode

        if code == 200 {
            // OK
        } else if code == 404 {
            throw RMAPIError.noResults
        } else {
            throw RMAPIError.badStatusCode(code)
        }

        let decoder: JSONDecoder = JSONDecoder()
        do {
            let decoded: EpisodeResponse = try decoder.decode(EpisodeResponse.self, from: data)
            return decoded
        } catch {
            throw RMAPIError.decodingFailed
        }
    }

    // MARK: - LOCATIONS
    func fetchLocations(page: Int, name: String?) async throws -> LocationResponse {

        let urlOptional: URL? = buildUrl(path: "location", page: page, name: name)
        if urlOptional == nil { throw RMAPIError.invalidUrl }

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
        if httpOptional == nil { throw RMAPIError.invalidResponse }

        let http: HTTPURLResponse = httpOptional!
        let code: Int = http.statusCode

        if code == 200 {
            // OK
        } else if code == 404 {
            throw RMAPIError.noResults
        } else {
            throw RMAPIError.badStatusCode(code)
        }

        let decoder: JSONDecoder = JSONDecoder()
        do {
            let decoded: LocationResponse = try decoder.decode(LocationResponse.self, from: data)
            return decoded
        } catch {
            throw RMAPIError.decodingFailed
        }
    }
}
