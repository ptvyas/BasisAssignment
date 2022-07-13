//
//  LoginUserRes.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation

class LoginUserRes {

    var Id: String = ""
    var avatar: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var phoneNumberVerified: Bool = false
    var email: String = ""
    var emailVerified: Bool = false
    var investmentSubscribed: Bool = false
    var rewards: Int = 0
    var nextGoal: Int = 0
    var referralToken: String = ""
    var referralMessage: String = ""
    var referralCount: Int?
    var badges: [Any] = []
    var onboardingStatus: String = ""
    var token: String = ""
    var hasMadeInvestments: Bool = false
    var isMandateApproved: Bool = false
    var rewardKeys: [Any] = []
    var basisStates: String = ""
    var customToken: String = ""
    var userVerified: Bool = false
    var basisTeam: Bool = false
    var communityAcceptance: Int?
    var creditCardState: String = ""

    init(_ dict: [String: Any]) {
        Id = dict["_id"] as? String ?? Id
        avatar = dict["avatar"] as? String ?? avatar
        firstName = dict["firstName"] as? String ?? firstName
        lastName = dict["lastName"] as? String ?? lastName
        phoneNumber = dict["phoneNumber"] as? String ?? phoneNumber
        phoneNumberVerified = dict["phoneNumberVerified"] as? Bool ?? phoneNumberVerified
        email = dict["email"] as? String ?? email
        emailVerified = dict["emailVerified"] as? Bool ?? emailVerified
        investmentSubscribed = dict["investmentSubscribed"] as? Bool ?? investmentSubscribed
        rewards = dict["rewards"] as? Int ?? rewards
        nextGoal = dict["nextGoal"] as? Int ?? nextGoal
        referralToken = dict["referralToken"] as? String ?? referralToken
        referralMessage = dict["referralMessage"] as? String ?? referralMessage
        referralCount = dict["referralCount"] as? Int ?? referralCount
        badges = dict["badges"] as? [Any] ?? badges
        onboardingStatus = dict["onboardingStatus"] as? String ?? onboardingStatus
        token = dict["token"] as? String ?? token
        hasMadeInvestments = dict["hasMadeInvestments"] as? Bool ?? hasMadeInvestments
        isMandateApproved = dict["isMandateApproved"] as? Bool ?? isMandateApproved
        rewardKeys = dict["rewardKeys"] as? [Any] ?? rewardKeys
        basisStates = dict["basisStates"] as? String ?? basisStates
        customToken = dict["customToken"] as? String ?? customToken
        userVerified = dict["userVerified"] as? Bool ?? userVerified
        basisTeam = dict["basisTeam"] as? Bool ?? basisTeam
        communityAcceptance = dict["communityAcceptance"] as? Int
        creditCardState = dict["creditCardState"] as? String ?? creditCardState
    }
}
