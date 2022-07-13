//
//  UtilityHTTPS+User.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation

extension UtilityHTTPS {
    func checkUser_Email(withEmail email : String, completionHandler : @escaping (_ objError : Error?, _ arrUser : [ModelUser]?) -> Void) {
        if !isConnectedToNetwork() {
            completionHandler(MyError.NoInternet, nil)
            return
        }
        guard let url = URL(string: API.user_email) else {
            completionHandler(MyError.InvalidData, nil)
            return
        }
        let dicParam = ["email" : email]
        
        UtilityHTTPS().requestPost(withEndPointURL: url, parameters: dicParam) { objError, responseData in
            print("objError: \(objError)")
            print("responseData: \(responseData)")
            
            if let objError = objError {
                print("objError: \(objError.localizedDescription)")
                
                completionHandler(objError, nil)
                return
            }
            
            var arrUser : [ModelUser] = []
            guard let userList = responseData as? [[String : Any]] else {
                completionHandler(MyError.EmptyData, arrUser)
                return
            }
            
            for dicUser in userList {
                let objUser = ModelUser.init(dicUser)
                arrUser.append(objUser)
            }
            completionHandler(nil, arrUser)
        }
    }
}

class ModelUser {
    
    init(_ dict: [String: Any]) {
    }
}
