//
//  SearchBar.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/06.
//

import SwiftUI
 
struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    var function: () -> Void
 
    var body: some View {
        HStack {
 
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if text != "" {
                Button(action: {
                    UIApplication.shared.endEditing()
                    self.function()
 
                }) {
                    Text("Search")
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
