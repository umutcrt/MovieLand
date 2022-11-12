


import Foundation

struct Welcome2: Codable {
    let dates: Dates2
    let page: Int
    let results: [Result2]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates2: Codable {
    let maximum, minimum: String
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
