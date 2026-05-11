import Foundation

// MARK: - Shared paging info
struct PageInfo: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

// MARK: - CHARACTERS
struct CharacterResponse: Codable {
    var info: PageInfo
    var results: [RMCharacter]
}

struct RMCharacter: Codable, Identifiable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: RMPlace
    var location: RMPlace
    var image: String
}

struct RMPlace: Codable {
    var name: String
    var url: String
}

// MARK: - EPISODES
struct EpisodeResponse: Codable {
    var info: PageInfo
    var results: [RMEpisode]
}

struct RMEpisode: Codable, Identifiable {
    var id: Int
    var name: String
    var air_date: String
    var episode: String
}

// MARK: - LOCATIONS
struct LocationResponse: Codable {
    var info: PageInfo
    var results: [RMLocation]
}


struct RMLocation: Codable, Identifiable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
}
