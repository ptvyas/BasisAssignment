//
//  AppConstants.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation
import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

struct STORYBOARD {
    static let Main : String = "Main"
    static let Home : String = "Home"
}


struct APP_MESSAGE {
    static let onWorkingProgress          = "On Working...."
    static let somethingWrong             = "Something went wrong"
    static let pleaseTryAgain             = "Please try again!"
           
    static let enterEmail               = "Please enter email address"
    static let enterValidEmail          = "Please enter valid email address"
    
    static let Resend_OPT_Success       = "OPT successfully."
    static let enterValidOTP            = "Please enter valid OTP"
}
