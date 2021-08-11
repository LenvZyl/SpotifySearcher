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
    @StateObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                SearchBar(searchViewModel: searchViewModel)
                    .padding(.top)
                    .padding(.bottom)
                
                if searchViewModel.loading{
                    ProgressView()
                }else{
                    if let artists = searchViewModel.searchResult?.artists {
                        ScrollView(.vertical) {
                            VStack(spacing: 10) {
                                ForEach(artists.items) { item in
                                    ArtistRowItem(item: item)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }.simultaneousGesture(
                            DragGesture().onChanged({_ in
                                UIApplication.shared.endEditing()
                            }))
                    }
                }
                Spacer()
            }.navigationBarTitle("Spotify Search")
            .background(LinearGradient(gradient: Constants.backgroundGradient, startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea(.all, edges: .all))
            .alert(isPresented: ($searchViewModel.showError), content: {
                Alert(title: Text("Alert"),
                      message: Text(searchViewModel.errorMessage),
                      dismissButton: .destructive(Text("Ok")))
            })
        }.accentColor(.white)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

