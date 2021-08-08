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
    
    @Published var errorMessage = ""
    @Published var accessToken: String? = nil
    @Published var searchText = ""
    @Published var searchResult: Artists? = nil
    var playURI = ""
    
    private var cancellable: AnyCancellable?
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func search(){
        guard let token = accessToken else {
            errorMessage = "Invalid Access token"
            return
        }
        let params = ["q": searchText, "type": "artist"]
        let url = URL(string: "https://api.spotify.com/v1/search?\(params.stringFromHttpParameters())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
         let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: Artists.self, decoder: JSONDecoder())
        self.cancellable = publisher.sink(receiveCompletion: { [weak self] completion in
            guard let strongSelf = self else{
                return
            }
            switch completion {
            case .finished:
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.errorMessage = error.localizedDescription
                }
            }
        }, receiveValue: { [weak self] posts in
            guard let strongSelf = self else{
                return
            }
            DispatchQueue.main.async {
                strongSelf.searchResult = posts
            }
        })
    }
}
