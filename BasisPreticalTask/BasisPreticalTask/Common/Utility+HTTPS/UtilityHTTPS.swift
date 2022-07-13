//
//  UtilityHTTPS.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation
import SystemConfiguration

class UtilityHTTPS {
    
    func requestGet(withEndPointURL url : URL,
                    completionHandler : @escaping (_ objError : Error?,
                                                   _ responseData : Any?) -> Void) {
        var request = URLRequest(url:url, timeoutInterval: Double.infinity)
        request.httpMethod = HTTPSMethod.GET.rawValue
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error accessing swapi.co: \(error.localizedDescription)")
              
                completionHandler(error, nil)
                return
            }
            var responseData : Any?
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                
                completionHandler(MyError.EmptyData, responseData)
                return
            }
            guard let data = data else {
                completionHandler(nil, nil)
                return
            }
            do {
                //Convert to Data
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                responseData = jsonData
                //print("jsonData: \(jsonData)")
                
                completionHandler(nil, responseData)
            } catch {
                print("Error: \(error.localizedDescription)")
                completionHandler(error, nil)
            }
            
        })
        task.resume()
    }
    
    func requestPost(withEndPointURL url : URL,
                     parameters : [String : Any],
                    completionHandler : @escaping (_ objError : Error?,
                                                   _ responseData : Any?) -> Void) {
        var request = URLRequest(url:url, timeoutInterval: Double.infinity)
        request.httpMethod = HTTPSMethod.POST.rawValue
        
        var postData = Data()
        do {
            postData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        catch let error {
            print("\(#function) | error: \(error.localizedDescription)")
        }
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("\(#function) | Error accessing swapi.co: \(error.localizedDescription)")
              
                completionHandler(error, nil)
                return
            }
            var responseData : Any?
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("\(#function) | Error with the response, unexpected status code: \(String(describing: response))")
                
                completionHandler(MyError.EmptyData, responseData)
                return
            }
            guard let data = data else {
                completionHandler(nil, nil)
                return
            }
            do {
                //Convert to Data
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                responseData = jsonData
                //print("jsonData: \(jsonData)")
                
                completionHandler(nil, responseData)
            } catch {
                print("\(#function) | Error: \(error.localizedDescription)")
                completionHandler(error, nil)
            }
            
        })
        task.resume()
    }
}

func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
        return false
    }
        
    // Working for Cellular and WIFI
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    let ret = (isReachable && !needsConnection)
    
    return ret
    
}

enum HTTPSMethod : String {
    case GET    = "get"
    case POST   = "post"
    case PUT    = "put"
}

//MARK:- Enums
enum MyError : Error {
    case NoInternet
    case EmptyData
    case InvalidData
}

extension MyError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .NoInternet:
            return NSLocalizedString("No Internet Connection!", comment: "")
            
        case .EmptyData:
            return NSLocalizedString("Empty data!", comment: "")
            
        case .InvalidData:
            return NSLocalizedString("Invalid data!", comment: "")
        }
    }
}
