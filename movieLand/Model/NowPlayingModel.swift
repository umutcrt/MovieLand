


import Foundation

struct Welcome: Codable {
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Result: Codable, Identifiable {
    let backdropPath: String
    let id: Int
    let overview: String
    let posterPath, releaseDate, title: String
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


