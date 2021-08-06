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
                        Spacer()
                    }.background(Color.white.ignoresSafeArea(.all, edges: .all))
                    
                }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
    }
}
