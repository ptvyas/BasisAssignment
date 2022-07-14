//
//  APIConstant.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation

struct API {
    static let domain           = "https://hiring.getbasis.co/"
    static let user_email       = API.domain + "candidate/users/email"
    static let verify_email     = API.domain + "candidate/users/email/verify"
    static let user_referral    = API.domain + "candidate/users/referral/%@"
}
