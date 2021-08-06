//
//  SearchViewModel.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel:NSObject, ObservableObject {
    
    var errorMessage = ""
    var accessToken: String? = nil
    var playURI = ""
    var searchText = ""
    
    var searchResult: [String] = []
    
    func search(){
        let url = URL(string: "https://api.spotify.com/v1/search?type\(searchText)")!
        let publisher = URLSession.shared.dataTaskPublisher(for: url).map{$0.data}.decode(type: String.self, decoder: JSONDecoder())
        
        let _ = publisher.sink(receiveCompletion: {completion in
            print(String(describing: completion))
        }, receiveValue: { value in
            print(value)
            
        })
    }
    
}
