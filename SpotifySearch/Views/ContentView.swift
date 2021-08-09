//
//  ContentView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/03.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("token") var token: String = ""
    
    init() {
        if(!TokenManager().checkTokenValidity()){
            TokenManager().removeToken()
        }
    }
    var body: some View {
        if(token == ""){
            LoginView()
        }else{
            SearchView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
