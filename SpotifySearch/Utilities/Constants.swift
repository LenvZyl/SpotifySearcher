//
//  Constants.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/03.
//

import Foundation
import SwiftUI

struct Constants {
    static let clientId = "Redacted"
    static let clientSecret = "Redacted"
    static let redirectUrl = URL(string: "spotifysearch://spotify/callback")!
    static let scope = "user-read-email"
    static let backgroundGradient = Gradient(colors: [Color(hex: 0x1DB954), Color(hex: 0x191414)])
    static let spotifyGreen = Color(hex: 0x1DB954)
}
