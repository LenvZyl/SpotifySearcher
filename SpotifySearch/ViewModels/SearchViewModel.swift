//
//  SearchViewModel.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var showError: Bool = false
    @Published var searchText = ""
    @Published var searchResult: Artists? = nil
    @Published var loading = false
    var playURI = ""
    
    
    private var searchCancellable: AnyCancellable? = nil
    private var searchGetCancellable: AnyCancellable? = nil
    
    private lazy var session: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.waitsForConnectivity = true
            return URLSession(configuration: configuration)
        }()
    
    init(){
        searchCancellable = $searchText
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    self.searchResult = nil
                }else{
                    self.search()
                }
                
            })
    }
    func search(){
        let tokenManager = TokenManager()
        if(!tokenManager.checkTokenValidity()){
            errorMessage = "Invalid Access token"
            showError = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                tokenManager.removeToken()
            }
        }
        guard let token = tokenManager.getToken() else {
            return
        }
        loading = true
        let params = ["q": searchText, "type": "artist"]
        let url = URL(string: "https://api.spotify.com/v1/search?\(params.stringFromHttpParameters())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let publisher = session.dataTaskPublisher(for: request)
        self.searchGetCancellable = publisher
            .map{$0.data}
            .decode(type: Artists.self, decoder: JSONDecoder())
            .mapError{ error -> Error in
                switch error{
                case URLError.cannotFindHost:
                    return APIError.networkError(error: error.localizedDescription)
                default:
                    return APIError.responseError(error: error.localizedDescription)
                }
            }
            .sink(receiveCompletion: { [weak self] completion in
            guard let strongSelf = self else{
                return
            }
            switch completion {
            case .finished:
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.loading = false
                    strongSelf.errorMessage = error.localizedDescription
                    strongSelf.showError = true
                }
            }
        }, receiveValue: { [weak self] posts in
            guard let strongSelf = self else{
                return
            }
            DispatchQueue.main.async {
                if(posts.artists.items.isEmpty){
                    strongSelf.errorMessage = "No results found"
                    strongSelf.showError = true
                }
                strongSelf.loading = false
                strongSelf.searchResult = posts
            }
        })
    }
}

enum APIError: Error{
    case networkError(error: String)
    case responseError(error: String)
    case unknownError
}
