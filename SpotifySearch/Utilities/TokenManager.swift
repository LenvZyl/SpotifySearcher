//
//  TokenManager.swift
//  SpotifySearch
//
//  Created by Len van Zyl on 2021/08/09.
//

import Foundation


class TokenManager {
    private let userDefaults = UserDefaults.standard
    func getToken() -> String? {
        guard let token = userDefaults.string(forKey: "token") else{
            return nil
        }
        return token
    }
    func checkTokenValidity() -> Bool{
        guard getToken() != nil else{
            return false
        }
        guard let tokenDate = userDefaults.object(forKey: "tokenDate") as? Date else{
            return false
        }
        let distanceTo = tokenDate.distance(to: Date())
        if(distanceTo >= 3600){
            return false
        }else{
            return true
        }
        
    }
    func storeToken(accessToken: String) {
        userDefaults.set(accessToken, forKey: "token")
        userDefaults.set(Date(), forKey: "tokenDate")
    }
    func removeToken(){
        userDefaults.removeObject(forKey: "token")
        userDefaults.removeObject(forKey: "tokenDate")
    }
    
}
