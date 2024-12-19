//
//  ResultDto.swift
//  Good Fact
//
//  Created by androiddev on 12/13/24.
//

struct ResultDto: Decodable {
    let id: String
    let text: String
    let source: String
    let sourceUrl: String
    let language: String
    let permalink: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case source
        case sourceUrl = "source_url"
        case language
        case permalink
    }
}

extension ResultDto {
    func toModel() -> Fact {
        return Fact(id: id, source: source, text: text)
    }
}
