//
//  Configuration.swift
//  HomeCam
//
//  Created by Yigang Zhou on 2020/1/9.
//  Copyright © 2020 Yigang Zhou. All rights reserved.
//

import UIKit

class Configuration: NSObject {
    
    fileprivate let userDefault = UserDefaults.standard
    
    func getServerUrl() -> String{
        let url = userDefault.string(forKey: "server")
        
        if url == nil {
            return "http://0.0.0.0"
        }else{
            return "http://" + url!
        }
    
    }
    
    func setServerUrl(url:String){
        userDefault.set(url, forKey: "server")
    }
    
    func getToken() -> String{
        let token = userDefault.string(forKey: "token")
        if token == nil {
            return "Not-Defined"
        }else{
            return token!
        }
    }
    
    func setToken(token:String){
        userDefault.set(token, forKey:"token")
    }
    

}
