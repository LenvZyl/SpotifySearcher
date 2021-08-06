//
//  SearchView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchViewModel = SearchViewModel()
    var body: some View {
        NavigationView {
            VStack{
                SearchBar(text: $searchViewModel.searchText)
                    .padding(.top)
                Spacer()
            }.navigationBarTitle("Spotify Search")
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
