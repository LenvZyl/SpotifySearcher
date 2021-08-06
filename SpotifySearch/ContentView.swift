//
//  ContentView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/03.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        
        LoginView(loginViewModel: loginViewModel).onOpenURL { url in
            loginViewModel.setAccessToken(from: url)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
            loginViewModel.connect()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
