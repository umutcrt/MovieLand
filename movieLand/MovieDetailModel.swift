


import Foundation

struct Welcome3: Codable {
    let id, page: Int
    let results: [Result3]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Result3: Codable, Identifiable {
    let author: String
    let authorDetails: AuthorDetails3
    let content, createdAt, id, updatedAt: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

struct AuthorDetails3: Codable {
    let name, username, avatarPath: String
    let rating: Int
    
    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
