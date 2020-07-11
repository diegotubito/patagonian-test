//
//  ServiceManager.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 10/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import UIKit

public enum ErrorService : String , Error {
    case wrongURL = "The URL sent is incorrect or in bad format."
    case serverError = "Server Error."
    case notFound = "Lyric not found."
  }

protocol ServiceManagerProtocol {
    func searchLyric(stringUrl: String, success: @escaping (LyricModel) -> (), fail: @escaping (ErrorService) -> Void)
    
}

class ServiceManager: ServiceManagerProtocol {
    static let shared = ServiceManager()
    
    func searchLyric(stringUrl: String, success: @escaping (LyricModel) -> (), fail: @escaping (ErrorService) -> Void) {
      
        let encode = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let adaptedUrl = encode, let url = NSURL(string: adaptedUrl) as URL? else {
            fail(ErrorService.wrongURL)
            return
        }
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as POST
      
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                fail(ErrorService.serverError)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let lyric = try JSONDecoder().decode(LyricModel.self, from: data)
                success(lyric)
            } catch {
                fail(ErrorService.notFound)
            }
            
        })
        task.resume()
    }
   
}
