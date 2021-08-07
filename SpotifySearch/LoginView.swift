//
//  LoginView.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack{
                GeometryReader{ geometry in
                    VStack{
                        Spacer()
                        Button(action: {loginViewModel.connect()}){
                            Text("Spotify Login")
                                .fontWeight(.bold)
                                .padding(.horizontal, 60)
                                .frame(height: 60)
                                .background(Color.red)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }.frame(width: geometry.size.width)
                        Button(action: {loginViewModel.getToken()}){
                            Text(loginViewModel.accessToken ?? "No")}
                        Spacer()
                    }.background(Color.white.ignoresSafeArea(.all, edges: .all))
                    if(loginViewModel.accessToken != nil){
                        
                        SearchView(searchViewModel: SearchViewModel(accessToken: loginViewModel.accessToken!))
                    }
                }
            
            
        }.onOpenURL { url in
            loginViewModel.setAccessToken(from: url)
        }
       
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
    }
}
