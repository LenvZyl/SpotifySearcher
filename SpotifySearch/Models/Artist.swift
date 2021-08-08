//
//  Artist.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//

import Foundation

struct Artist: Decodable {
    let href: String
    let items: [Item]
}
