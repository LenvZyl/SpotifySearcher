//
//  ArtistRowItem.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/08.
//

import SwiftUI

struct ArtistRowItem: View {
    var item: Item
    
    var body: some View {
        VStack{
            NavigationLink(destination: ArtistView(item: item)) {
                HStack{
                    Text(item.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                }.frame(height: 60, alignment: .leading)
                .padding(.horizontal)
            }
            Divider()
        }
    }
}

