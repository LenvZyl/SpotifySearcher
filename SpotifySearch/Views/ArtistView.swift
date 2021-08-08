//
//  ArtistView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//

import SwiftUI

struct ArtistView: View {
    var body: some View {
        Image("")
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistView()
    }
}


//struct RemoteImage: View {
//
//    @StateObject var loader = Loader(url: "")
//    var loading: Image
//    var failure: Image
//
//    var body: some View {
//            selectImage()
//        
//    }
//
//    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
//        _loader = StateObject(wrappedValue: Loader(url: url))
//        self.loading = loading
//        self.failure = failure
//    }
//
//    private func selectImage() -> Image {
//        switch loader.state {
//        case .loading:
//            return loading
//        case .failure:
//            return failure
//        default:
//            if let image = UIImage(data: loader.data) {
//                return Image(uiImage: image)
//                
//            } else {
//                return failure
//            }
//        }
//    }
//}

