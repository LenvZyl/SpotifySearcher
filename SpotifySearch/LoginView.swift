//
//  LoginView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack{
            Button(action: {
                loginViewModel.connect()
            }, label: {Text("Connect")})
            Button(action: {
                loginViewModel.getToken()
            }, label: {Text("Print Token")})
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
    }
}
