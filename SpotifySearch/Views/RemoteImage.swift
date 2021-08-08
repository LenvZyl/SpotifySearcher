//
//  RemoteImage.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//

import SwiftUI

struct RemoteImage: View {

    @StateObject private var loader: ImageViewModel
    
    var body: some View {
        selectImage()
    }
    init(url: String) {
        _loader = StateObject(wrappedValue: ImageViewModel(url: url))
    }
    private func selectImage() -> AnyView {
        switch loader.state {
        case .loading:
            return AnyView(ProgressView())
        case .failure:
            return AnyView(Text("Failed to download Image").fontWeight(.bold))
        default:
            if let image = UIImage(data: loader.data) {
                return AnyView(ImageView(image: image))
            } else {
                return AnyView(Text("Failed to download Image").fontWeight(.bold))
            }
        }
    }
}
struct ImageView: View {
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    var body: some View {
        Image(uiImage: image).resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: 250.0, alignment: .top)
            .clipped()
    }
}
