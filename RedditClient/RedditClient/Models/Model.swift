//
//  Model.swift
//  RedditClient
//
//  Created by Axel Mosiejko on 08/03/2020.
//  Copyright © 2020 Axel Mosiejko. All rights reserved.
//

import Foundation

struct Model: Decodable {
    let data : Children?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct ListingData: Decodable {
    let children: Children?
}

struct Children: Decodable {
    let data: [Child]?
    enum CodingKeys: String, CodingKey {
        case data = "children"
    }
}

struct Child: Decodable {
    let childData: ChildData?
    enum CodingKeys: String, CodingKey {
        case childData = "data"
    }
}

struct ChildData: Decodable {
    let author : String?
    let title : String?
    let date: Int?
    let thumbnail: String?
    let num_comments: Int?
    let selftext: String?
    let name: String?
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case date = "created"
        case thumbnail = "thumbnail"
        case num_comments = "num_comments"
        case selftext = "selftext"
        case name = "name"
    }
     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        author = try values.decodeIfPresent(String.self, forKey: .author)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        date = try values.decodeIfPresent(Int.self, forKey: .date)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        num_comments = try values.decodeIfPresent(Int.self, forKey: .num_comments)
        selftext = try values.decodeIfPresent(String.self, forKey: .selftext)
        name = try values.decodeIfPresent(String.self, forKey: .name)
     }
}
