//
//  RemoteImage.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//

import SwiftUI

struct RemoteImage: View {

    @StateObject private var loader: Loader
    
    var body: some View {
        selectImage()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: 250.0, alignment: .top)
            .clipped()
            
    }

    init(url: String) {
        _loader = StateObject(wrappedValue: Loader(url: url))
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return Image(systemName: "photo")
        case .failure:
            return Image(systemName: "multiply.circle")
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return Image(systemName: "multiply.circle")
            }
        }
    }
}
