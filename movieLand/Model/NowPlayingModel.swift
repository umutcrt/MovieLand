


import Foundation

struct Welcome: Codable {
    let results: [Result]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
}

struct Result: Codable, Identifiable, Hashable {
    let backdropPath: String?
    let id: Int
    let overview: String
    let posterPath: String?
    let releaseDate, title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}


