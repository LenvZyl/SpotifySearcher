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
 
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "magnifyingglass").padding()
            TextField("Search ...", text: $searchViewModel.searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onTapGesture {
                    self.isEditing = true
                }
            if searchViewModel.searchText != "" {
                Button(action: {
                    UIApplication.shared.endEditing()
                    searchViewModel.searchText = ""
                }) {
                    Text("Clear")
                    .foregroundColor(Color.white)
                    .frame(width: 50)
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical)
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
