//
//  OTPVrificationVC.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import UIKit
import SVPinView

class EmailVarificationVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var OTPView: SVPinView!
    
    //MARK: - Variables
    var objLoginRes : LoginRes?
    var userEmail = String()
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Button action method
    @IBAction func btnBackAction(_ sender: UIButton) {
        hideKeyboard(self)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnResetOTPAction(_ sender: UIButton) {
        hideKeyboard(self)
        showAlertMessage(nil, APP_MESSAGE.onWorkingProgress, onViewController: self)
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        hideKeyboard(self)
              
        //Email
        let vValidationMess : String = [APP_MESSAGE.somethingWrong, APP_MESSAGE.pleaseTryAgain].joined(separator: "\n")
        if self.userEmail.isEmpty {
            showAlertMessage(nil, vValidationMess, onViewController: self)
            return
        }
        
        //Token
        guard let objLoginRes = objLoginRes else { return }
        let vToken = objLoginRes.token
        if vToken == 0 {
            showAlertMessage(nil, vValidationMess, onViewController: self)
            return
        }
        
        //OTP
        let vOTP : String = self.OTPView.getPin().trim()
        if vOTP.isEmpty {
            showAlertMessage(nil, APP_MESSAGE.enterValidOTP, onViewController: self)
            return
        }
        
        let dicParam = ["email" : self.userEmail,
                        "token" : vToken,
                        "verificationCode" : vOTP] as [String : Any]
        
        showLoader()
        UtilityHTTPS().verify_Email(withParam: dicParam) { objError, isSuccess, apiMessage, objUser, objUserInfo in
            hideLoader()
            runOnMainThread {
            if let objError = objError {
                showAlertMessage(nil, objError.localizedDescription, onViewController: self)
                self.OTPView.clearPin()
                return
            }
            
            let vMessge : String = apiMessage ?? [APP_MESSAGE.somethingWrong, APP_MESSAGE.pleaseTryAgain].joined(separator: "\n")
            if !isSuccess {
                showAlertMessage(nil, vMessge, onViewController: self)
                self.OTPView.clearPin()
                return
            }
            guard let objUser = objUser else {
                showAlertMessage(nil, vMessge, onViewController: self)
                self.OTPView.clearPin()
                return
            }
            
            if objUser.isLogin {
                guard let objUserInfo = objUserInfo else {
                    showAlertMessage(nil, vMessge, onViewController: self)
                    self.OTPView.clearPin()
                    return
                }
                //Move to Home Screen
                guard let objVC = loadVC(strStoryboardId: STORYBOARD.Home, strVCId: "HomeVC") as? HomeVC else { return }
                objVC.objLoginUserRes = objUserInfo
                self.navigationController?.pushViewController(objVC, animated: true)
                return
            }
            
            //Move to SignUp Screen
            guard let objVC = loadVC(strStoryboardId: STORYBOARD.Main, strVCId: "SignUpVC") as? SignUpVC else { return }
            objVC.userEmail = self.userEmail
            self.navigationController?.pushViewController(objVC, animated: true)
            }
        }
    }
}

extension EmailVarificationVC {
     func setupUI() {
         OTPView.style = .box
         OTPView.becomeFirstResponderAtIndex = 0
    }
}
