//
//  UtilityHTTPS+User.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation

extension UtilityHTTPS {
    func checkUser_Email(withEmail email : String, completionHandler : @escaping (_ objError : Error?,
                                                                                  _ isSuccess : Bool,
                                                                                  _ message : String?,
                                                                                  _ objUser : LoginRes?) -> Void) {
        if !isConnectedToNetwork() {
            completionHandler(MyError.NoInternet, false, nil, nil)
            return
        }
        guard let url = URL(string: API.user_email) else {
            completionHandler(MyError.InvalidData, false, nil, nil)
            return
        }
        let dicParam = ["email" : email]
        
        UtilityHTTPS().requestPost(withEndPointURL: url, parameters: dicParam) { objError, responseData in
            //print("objError: \(objError)")
            //print("responseData: \(responseData)")
            
            var isSuccess : Bool = false
            var vMessage : String?
            var objLoginRes : LoginRes?
            
            if let objError = objError {
                print("objError: \(objError.localizedDescription)")
                
                completionHandler(objError, isSuccess, vMessage, nil)
                return
            }
            guard let dicData = responseData else {
                completionHandler(MyError.EmptyData, isSuccess, vMessage, nil)
                return
            }
            
            //isSuccess
            isSuccess = self.getIsSuccessStatus(withResponse: dicData)
            
            //Message
            vMessage = self.getMessage(withResponse: dicData)
            
            //User Result
            if let dicResult = dicData["results"] as? [String : Any] {
                objLoginRes = LoginRes.init(dicResult)
            }
            
            completionHandler(nil, isSuccess, vMessage, objLoginRes)
        }
    }
}

extension UtilityHTTPS {
    internal func getIsSuccessStatus(withResponse dicData : AnyObject?) -> Bool {
        guard let dicData = dicData else {
            return false
        }
        var isSuccess : Int = 0
        if let value = dicData["success"] as? Int {
            isSuccess = value
        }
        return (isSuccess == 1)
    }
    internal func getMessage(withResponse dicData : AnyObject?) -> String {
        var vMess : String = ""
        
        guard let dicData = dicData else {
            return vMess
        }
        if let value = dicData["message"] as? String {
            vMess = value
        }
        return vMess
    }
}
