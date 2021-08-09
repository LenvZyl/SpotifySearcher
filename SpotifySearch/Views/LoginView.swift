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
                        Text("Login with Spotify")
                            .fontWeight(.bold)
                            .padding(.horizontal, 80)
                            .frame(height: 60)
                            .background(Constants.spotifyGreen)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            .shadow(color: Color.white, radius: 3)
                    }.frame(width: geometry.size.width)
                    .padding(.vertical, 80)
                 }
                .background(LinearGradient(gradient: Constants.backgroundGradient,
                                           startPoint: .top,
                                           endPoint: .bottom)
                                .ignoresSafeArea(.all, edges: .all))
                .alert(isPresented: ($loginViewModel.showError), content: {
                    Alert(title: Text("Alert"),
                          message: Text(loginViewModel.errorMessage),
                          dismissButton: .destructive(Text("Ok")))
                })
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
