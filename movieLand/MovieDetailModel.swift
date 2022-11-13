


import Foundation

struct Welcome3: Codable {
    let id: Int
    let results: [Result3]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case id, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Result3: Codable, Identifiable {
    let content, id: String
    
    enum CodingKeys: String, CodingKey {
        case content
        case id
    }
}
