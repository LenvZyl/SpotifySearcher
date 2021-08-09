//
//  SearchViewModel.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel:NSObject, ObservableObject, URLSessionDelegate {
    
    @Published var errorMessage = ""
    @Published var showError: Bool = false
    @Published var searchText = ""
    @Published var searchResult: Artists? = nil
    var playURI = ""
    
    private var cancellable: AnyCancellable?
    
    private lazy var session: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.waitsForConnectivity = true
            return URLSession(configuration: configuration,
                              delegate: self, delegateQueue: nil)
        }()
    func search(){
        guard let token = TokenManager().getToken() else {
            errorMessage = "Invalid Access token"
            showError = true
            return
        }
        let params = ["q": searchText, "type": "artist"]
        let url = URL(string: "https://api.spotify.com/v1/search?\(params.stringFromHttpParameters())")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let publisher = session.dataTaskPublisher(for: request)
        self.cancellable = publisher
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
                    strongSelf.errorMessage = error.localizedDescription
                    strongSelf.showError = true
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

enum APIError: Error{
    case networkError(error: String)
    case responseError(error: String)
    case unknownError
}
