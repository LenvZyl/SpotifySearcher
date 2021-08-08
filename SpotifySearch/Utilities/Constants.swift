//
//  Constants.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/03.
//

import Foundation
import SwiftUI

struct Constants {
    static let clientId = "85cb7f0093564f5b8e15e2fe02680790"
    static let clientSecret = "9f3fb3bd084e49fa900310118208e0aa"
    static let redirectUrl = URL(string: "spotifysearch://spotify/callback")!
    static let scope = "user-read-email"
    static let backgroundGradient = Gradient(colors: [Color(hex: 0x1DB954), Color(hex: 0x191414)])
    static let spotifyGreen = Color(hex: 0x1DB954)
}
