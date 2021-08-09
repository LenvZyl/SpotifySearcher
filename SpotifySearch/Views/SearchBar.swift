//
//  SearchBar.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import SwiftUI
 
struct SearchBar: View {
    @StateObject var searchViewModel: SearchViewModel
    @State private var isEditing = false
    var function: () -> Void
    
 
    var body: some View {
        HStack {
            TextField("Search ...", text: $searchViewModel.searchText)
                .padding(7)
                .padding(.horizontal, 10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            if searchViewModel.searchText != "" {
                Button(action: {
                    if(!searchViewModel.loading) {
                        UIApplication.shared.endEditing()
                        self.function()
                    }
                }) {
                    if(searchViewModel.loading) {
                        ProgressView().frame(width: 50)
                    } else {
                        Text("Search")
                        .foregroundColor(Color.white)
                        .frame(width: 50)
                    }
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
                
            }
        }
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
