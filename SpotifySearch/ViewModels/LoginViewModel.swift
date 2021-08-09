//
//  LoginViewModel.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/04.
//

import SwiftUI
import Combine
import Network

class LoginViewModel:NSObject, ObservableObject {
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var accessToken: String? = nil
    var playURI = ""
    
    let monitor = NWPathMonitor()
    let spotifyClientID = Constants.clientId
    let spotifyRedirectURL = Constants.redirectUrl
    
    lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )
       
    private var disconnectCancellable: AnyCancellable?
    
    override init() {
        super.init()
        if let token = TokenManager().getToken() {
            self.accessToken = token
        }
    }
            
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    func setAccessToken(from url: URL) {
        let parameters = appRemote.authorizationParameters(from: url)
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
            TokenManager().storeToken(accessToken: accessToken)
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            errorMessage = errorDescription
            showError = true
        }else{
            errorMessage = "Spotify Login Failed, please try again later!"
            showError = true
        }
    }
    
    func connect() {
        guard let _ = self.appRemote.connectionParameters.accessToken else {
            self.appRemote.authorizeAndPlayURI(playURI)
            return
        }
        appRemote.connect()
    }
    
    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }
}

extension LoginViewModel: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.appRemote = appRemote
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        errorMessage = error?.localizedDescription ?? "Spotify Login failed"
        showError = true
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
}
extension LoginViewModel: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {}
}

    

