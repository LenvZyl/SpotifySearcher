//
//  ArtistView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//

import SwiftUI

struct ArtistView: View {
    var artist: Item
    var genres: String = ""
    
    init(item: Item) {
        self.artist = item
        genres = item.genres.reduce("", { $0 == "" ? $1.firstUppercased : $0.firstUppercased  + ", " + $1.firstUppercased})
        genres = item.genres.map(\.capitalized).joined(separator: ", ")
    }
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottom){
                RemoteImage(url: artist.images.first?.url ?? "")
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                Text(artist.name)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .shadow(radius: 2)
                    .frame(width: UIScreen.main.bounds.width).padding()
            }
            HStack{
                VStack{
                    Text("Type:")
                        .padding(.horizontal, 10)
                        .padding(.bottom, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.gray.opacity(0.9))
                    
                    Text(artist.type.firstUppercased)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal)
            .frame(height: 60, alignment: .leading)
            HStack{
                VStack{
                    Text("Genres:")
                        .padding(.horizontal, 10)
                        .padding(.bottom, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.gray.opacity(0.9))
                    Text(genres)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal)
            .frame(alignment: .leading)
           Spacer()
        }
        .background(LinearGradient(gradient: Constants.backgroundGradient, startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea(.all, edges: .all))
    }
}



