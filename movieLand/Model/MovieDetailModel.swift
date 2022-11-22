


import Foundation

struct Welcome3: Codable {
    let id: Int
    let results: [Result3]
    
    enum CodingKeys: String, CodingKey {
        case id, results
    }
}

struct Result3: Codable, Identifiable {
    let content, id: String
    
    enum CodingKeys: String, CodingKey {
        case content
        case id
    }
}
