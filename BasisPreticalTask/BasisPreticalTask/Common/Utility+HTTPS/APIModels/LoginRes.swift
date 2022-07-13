//
//  LoginModelRes.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation

class LoginRes {
    var wrongEmailTokenCount: Int = 0
    var resendEmailTokenCount: Int = 0
    var token: Int = 0
    var isLogin: Bool = false

    init(_ dict: [String: Any]) {
        wrongEmailTokenCount = dict["wrongEmailTokenCount"] as? Int ?? wrongEmailTokenCount
        resendEmailTokenCount = dict["resendEmailTokenCount"] as? Int ?? resendEmailTokenCount
        token = dict["token"] as? Int ?? token
        isLogin = dict["isLogin"] as? Bool ?? isLogin
    }
}
