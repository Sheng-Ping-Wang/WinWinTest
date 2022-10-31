//
//  WebService.swift
//  WinWinTest
//
//  Created by Wang Sheng Ping on 2022/10/31.
//

import Foundation

class WebService{
    
    static let shared = WebService()
    
    private init() {
        
    }
    
    func getUserInfo(completionHandler: @escaping (Result<UserInfo, Error>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/winwiniosapp/interview/main/interview.json") else {
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, err in
            guard let data = data, err == nil else {
                print(err as Any)
                return
            }
            
//            let info = try JSONDecoder().decode(UserInfo, from: data)
            
            do{
                let decoder = JSONDecoder()
                let info = try decoder.decode(UserInfo.self, from: data)
                print(info)
                completionHandler(.success(info))
            }catch{
                print(error)
                completionHandler(.failure(error))
            }
            
        }.resume()
        
        
    }
    
    
}
