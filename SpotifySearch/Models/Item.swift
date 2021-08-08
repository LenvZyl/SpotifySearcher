//
//  Item.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//

import Foundation

struct Item: Decodable, Identifiable {
    let name: String
    let type: String
    let uri: String
    let id: String
    let genres: [String]
    let images: [ImageUrl]
}
