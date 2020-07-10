//
//  BaseServiceManager.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 10/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import Foundation

public enum ErrorService : String , Error {
    case wrongURL = "The URL sent is incorrect or in bad format."
    case serverError = "Server Error."
    case notFound = "URL not found."
    case badRequest = "Bad Request."
    case dataNil = "Data nil."
    case body_serialization = "Body error serialization."
    case notReachable = "There is no internet connection."
    case unhandleError = "Could not resolve error type."
   
}

class BaseServerManager {

    func request(stringURL: String, method: String, body: [String : Any]?, success: @escaping (Data) -> (), fail: @escaping (ErrorService) -> ()) {
        
//      First check for connectivity
        if !Reachability.shared.isConnectedToNetwork() {
            fail(ErrorService.notReachable)
            return
        }
        
        let encode = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let adaptedUrl = encode, let url = NSURL(string: adaptedUrl) as URL? else {
            fail(ErrorService.wrongURL)
            return
        }
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = method //set http method as POST
        //declare parameter as a dictionary which contains string as key and value combination.
        if let parameters = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
            } catch {
                fail(ErrorService.body_serialization)
                return
            }
        }
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //Token
        let token = UserSession.GetSessionToken()
        request.addValue(token, forHTTPHeaderField: "Authorization")
        //Session
        //Timeout configuration
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 8.0
        sessionConfig.timeoutIntervalForResource = 16.0
        
        //create the session object
        let session = URLSession(configuration: sessionConfig)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, res, error in
            
            guard error == nil else {
                fail(ErrorService.serverError)
                return
            }
            
            guard let data = data else {
                fail(ErrorService.dataNil)
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode == 200 {
                    success(data)
                } else {
                    if statusCode == 404 {
                        fail(ErrorService.notFound)
                        return
                    } else if statusCode == 400 {
                        fail(ErrorService.badRequest)
                        return
                    } else {
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                        let errorMessage = json?["message"] as? String
                        print(errorMessage ?? "")
                        
                        fail(ErrorService.unhandleError)
                        return
                    }
                }
            }
        })
        task.resume()
    }
}
