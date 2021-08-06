//
//  ContentView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/03.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    private let webUrl = URL(string: "https://accounts.spotify.com/authorize?response_type=token&client_id=\( Constants.clientId)&scope=\(Constants.scope)&redirect_uri=spotifysearch://spotify/callback")!
    var body: some View {
        VStack{
            Button(action: {
                loginViewModel.connect()
            }, label: {Text("Connect")})
            Button(action: {
                loginViewModel.disconnect()
            }, label: {Text("Print Token")})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
