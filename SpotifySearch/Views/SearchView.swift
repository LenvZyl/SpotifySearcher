//
//  SearchView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import SwiftUI
import Combine
import Foundation
import UIKit


struct SearchView: View {
    @StateObject var searchViewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                SearchBar(text: $searchViewModel.searchText, function: searchViewModel.search)
                    .padding(.top)
                    .padding(.bottom)
            
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
            .background(LinearGradient(gradient: Constants.backgroundGradient, startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea(.all, edges: .all))
        }.accentColor(.white)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchViewModel: SearchViewModel(accessToken: ""))
    }
}
