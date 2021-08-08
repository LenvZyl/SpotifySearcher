//
//  ArtistViewModel.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//

import Foundation
class ArtistViewModel: ObservableObject {
    
}

enum LoadState {
    case loading, success, failure
}

class Loader: ObservableObject {
    var data = Data()
    var state = LoadState.loading

    init(url: String) {
        guard let parsedURL = URL(string: url) else {
            fatalError("Invalid URL: \(url)")
        }

        URLSession.shared.dataTask(with: parsedURL) { data, response, error in
            if let data = data, data.count > 0 {
                self.data = data
                self.state = .success
            } else {
                self.state = .failure
            }

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }.resume()
    }
}

