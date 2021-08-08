//
//  ArtistViewModel.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//
import SwiftUI
import Foundation

class ImageViewModel: ObservableObject {
    var data = Data()
    var state = LoadState.loading

    init(url: String) {
        guard let parsedURL = URL(string: url) else {
            self.state = .failure
            return
        }
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        URLSession(configuration: config).dataTask(with: parsedURL) { [weak self] data, response, error in
            guard let strongSelf = self else {
                return
            }
            if let data = data, data.count > 0 {
                strongSelf.data = data
                strongSelf.state = .success
            } else {
                strongSelf.state = .failure
            }
            DispatchQueue.main.async {
                strongSelf.objectWillChange.send()
            }
        }.resume()
    }
}
enum LoadState {
    case loading, success, failure
}


