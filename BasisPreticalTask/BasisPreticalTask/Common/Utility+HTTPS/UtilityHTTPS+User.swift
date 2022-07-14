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
            
            var isSuccess : Bool = false
            var vMessage : String?
            var objLoginUserRes : LoginRes?
            
            if let objError = objError {
                print("objError: \(objError.localizedDescription)")
                
                completionHandler(objError, isSuccess, vMessage, objLoginUserRes)
                return
            }
            guard let dicData = responseData else {
                completionHandler(MyError.EmptyData, isSuccess, vMessage, objLoginUserRes)
                return
            }
            
            //isSuccess
            isSuccess = self.getIsSuccessStatus(withResponse: dicData)
            
            //Message
            vMessage = self.getMessage(withResponse: dicData)
            
            //User Result
            if let dicResult = dicData["results"] as? [String : Any] {
                objLoginUserRes = LoginRes.init(dicResult)
            }
            
            completionHandler(nil, isSuccess, vMessage, objLoginUserRes)
        }
    }
    
    func verify_Email(withParam dicParam : [String : Any], completionHandler : @escaping (_ objError : Error?,
                                                                                          _ isSuccess : Bool,
                                                                                          _ message : String?,
                                                                                          _ objUser : LoginRes?,
                                                                                          _ objUserInfo : LoginUserRes?) -> Void) {
        if !isConnectedToNetwork() {
            completionHandler(MyError.NoInternet, false, nil, nil, nil)
            return
        }
        guard let url = URL(string: API.verify_email) else {
            completionHandler(MyError.InvalidData, false, nil, nil, nil)
            return
        }
        
        UtilityHTTPS().requestPost(withEndPointURL: url, httpMethod: .PUT, parameters: dicParam) { objError, responseData in
            
            var isSuccess : Bool = false
            var vMessage : String?
            var objLoginUserRes : LoginRes?
            var objLoginUserInfoRes : LoginUserRes?
            
            if let objError = objError {
                print("objError: \(objError.localizedDescription)")
                
                completionHandler(objError, isSuccess, vMessage, objLoginUserRes, objLoginUserInfoRes)
                return
            }
            guard let dicData = responseData else {
                completionHandler(MyError.EmptyData, isSuccess, vMessage, objLoginUserRes, objLoginUserInfoRes)
                return
            }
            
            //isSuccess
            isSuccess = self.getIsSuccessStatus(withResponse: dicData)
            
            //Message
            vMessage = self.getMessage(withResponse: dicData)
            
            //User Result
            if let dicResult = dicData["results"] as? [String : Any] {
                objLoginUserRes = LoginRes.init(dicResult)
                
                //User Result Info
                if let dicUserInfo = dicResult["user"] as? [String : Any] {
                    objLoginUserInfoRes = LoginUserRes.init(dicUserInfo)
                }
            }
            completionHandler(nil, isSuccess, vMessage, objLoginUserRes, objLoginUserInfoRes)
        }
    }
    
    func referNow(withCode referCode: String, completionHandler : @escaping (_ objError : Error?,
                                                                                          _ isSuccess : Bool,
                                                                                          _ message : String?,                        _ objUserInfo : LoginUserRes?) -> Void) {
        if !isConnectedToNetwork() {
            completionHandler(MyError.NoInternet, false, nil, nil)
            return
        }
        
        let endPoint : String = String(format: API.user_referral, referCode)
        guard let url = URL(string: endPoint) else {
            completionHandler(MyError.InvalidData, false, nil, nil)
            return
        }
        
        UtilityHTTPS().requestGet(withEndPointURL: url) { objError, responseData in
            
            var isSuccess : Bool = false
            var vMessage : String?
            var objLoginUserInfoRes : LoginUserRes?
            
            if let objError = objError {
                print("objError: \(objError.localizedDescription)")
                
                completionHandler(objError, isSuccess, vMessage, objLoginUserInfoRes)
                return
            }
            guard let dicData = responseData else {
                completionHandler(MyError.EmptyData, isSuccess, vMessage, objLoginUserInfoRes)
                return
            }
            
            //isSuccess
            isSuccess = self.getIsSuccessStatus(withResponse: dicData)
            
            //Message
            vMessage = self.getMessage(withResponse: dicData)
            
            //User Result
            if let dicResult = dicData["results"] as? [String : Any] {
                objLoginUserInfoRes = LoginUserRes.init(dicResult)
            }
            completionHandler(nil, isSuccess, vMessage, objLoginUserInfoRes)
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
