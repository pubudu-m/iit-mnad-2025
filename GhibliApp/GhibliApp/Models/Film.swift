//
//  Film.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import Foundation

struct Film: Identifiable, Decodable, Equatable, Hashable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String
    let releaseYear: String
    let score: String
    let duration: String
    let image: String
    let bannerImage: String
    let people: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people
        case bannerImage = "movie_banner"
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
    }
}
