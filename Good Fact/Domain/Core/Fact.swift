//
//  Fact.swift
//  Good Fact
//
//  Created by androiddev on 12/13/24.
//

struct Fact: Identifiable {
    let id: String
    let source: String
    let text: String
    
    public init(id: String, source: String, text: String) {
        self.id = id
        self.source = source
        self.text = text
    }
}
