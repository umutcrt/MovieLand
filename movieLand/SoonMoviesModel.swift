


import Foundation

struct Welcome2: Codable {
    let results: [Result2]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Result2: Codable, Identifiable {
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
