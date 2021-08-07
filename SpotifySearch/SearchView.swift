//
//  SearchView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchViewModel: SearchViewModel
    var body: some View {
        NavigationView {
            VStack{
                SearchBar(text: $searchViewModel.searchText)
                    .padding(.top)
                Button(action: {searchViewModel.search()}){
                    Text("Search")}
                if let artists = searchViewModel.searchResult?.artists {
                    ScrollView(.vertical) {
                        VStack(spacing: 10) {
                            ForEach(artists.items) { item in
                                ArtistRowItem(item: item)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                }
                Spacer()
            }.navigationBarTitle("Spotify Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchViewModel: SearchViewModel(accessToken: ""))
    }
}



struct ArtistRowItem: View {
    var item: Item

    var body: some View {
        VStack{
        HStack{
            Text(item.name).frame(maxWidth: .infinity, alignment: .leading)
        }.frame(height: 60, alignment: .leading)
        .background(Color.red)
            Divider()
        }
        
    }
}
