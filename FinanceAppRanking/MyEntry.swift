//
//  MyEntry.swift
//  FinanceAppRanking
//
//  Created by Juyeon Kim on 2018. 4. 19..
//  Copyright © 2018년 Juyeon Kim. All rights reserved.
//

import Foundation

struct MyEntry: Codable {
    
    let feed:Feed?
    
    private enum CodingKeys: String, CodingKey {
        case feed
    }
}

struct Feed: Codable {
    
    let author: Author
    let entry: [Entry]
    
    private enum CodingKeys: String, CodingKey {
        case author, entry
    }
}

struct Author: Codable {
    let name: Attributes
    let uri: Attributes
    
    private enum CodingKeys: String, CodingKey {
        case name, uri
    }
}


struct Entry: Codable {
    let name: Attributes
    let images: [Attributes]
    let summary: Attributes
    let price: Attributes
    let rights: Attributes
    let title: Attributes
    let link: Attributes
    let id: Attributes
    let artist: Attributes
    let category: Attributes
    let releaseDate: Attributes
    
    private enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case images = "im:image"
        case summary
        case price = "im:price"
        case rights
        case title
        case link
        case id
        case artist = "im:artist"
        case category
        case releaseDate = "im:releaseDate"
    }
}

struct Attributes: Codable {
    let label: String?
    let attributes:Attr?
    
    private enum CodingKeys: String, CodingKey {
        case label, attributes
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = (try? values.decode(String.self, forKey: .label)) ?? ""
        attributes = try? values.decode(Attr.self, forKey: .attributes)
    }
}

struct Attr: Codable {
    let label: String?
    let height: String?
    let amount: String?
    let currency: String?
    let term: String?
    let rel: String?
    let type: String?
    let href: String?
    let id: String?
    let bundleId: String?
    let scheme: String?
    
    private enum CodingKeys: String, CodingKey {
        case height, amount, currency, term, label, rel, type, href, id = "im:id", bundleId = "im:bundleId", scheme
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = (try? values.decode(String.self, forKey: .label)) ?? ""
        height = (try? values.decode(String.self, forKey: .height)) ?? ""
        amount = (try? values.decode(String.self, forKey: .amount)) ?? ""
        currency = (try? values.decode(String.self, forKey: .currency)) ?? ""
        term = (try? values.decode(String.self, forKey: .term)) ?? ""
        rel = (try? values.decode(String.self, forKey: .rel)) ?? ""
        type = (try? values.decode(String.self, forKey: .type)) ?? ""
        href = (try? values.decode(String.self, forKey: .href)) ?? ""
        id = (try? values.decode(String.self, forKey: .id)) ?? ""
        bundleId = (try? values.decode(String.self, forKey: .bundleId)) ?? ""
        scheme = (try? values.decode(String.self, forKey: .scheme)) ?? ""
    }
    
}
