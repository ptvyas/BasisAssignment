//
//  EmailVC.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import UIKit

class EmailVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK: - Variabes
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Testing purpose
        self.txtEmail.text = "mayank@getbasis.co" //App User
    }
        
    // MARK: - Button actions
    @IBAction func btnEmailAction(_ sender: UIButton) {
        hideKeyboard(self)
        
        let vEmail : String = (self.txtEmail.text ?? "").trim()
        if vEmail.isEmpty {
            showAlertMessage(nil, APP_MESSAGE.enterEmail, onViewController: self)
            return
        }
        
        if !isValidEmail(vEmail) {
            showAlertMessage(nil, APP_MESSAGE.enterValidEmail, onViewController: self)
            return
        }
        
        showLoader()
        UtilityHTTPS().checkUser_Email(withEmail: vEmail) { objError, isSuccess, apiMessage, objUser in
            hideLoader()
            if let objError = objError {
                showAlertMessage(nil, objError.localizedDescription, onViewController: self)
                return
            }
            
            let vMessge : String = apiMessage ?? [APP_MESSAGE.somethingWrong, APP_MESSAGE.pleaseTryAgain].joined(separator: "\n")
            if !isSuccess {
                showAlertMessage(nil, vMessge, onViewController: self)
                return
            }
            guard let objUser = objUser else {
                showAlertMessage(nil, vMessge, onViewController: self)
                return
            }
            //Move to Verify Email
            runOnMainThread {                
            guard let objVC = loadVC(strStoryboardId: STORYBOARD.Main, strVCId: "EmailVarificationVC") as? EmailVarificationVC else { return }
            objVC.userEmail = vEmail
            objVC.objLoginRes = objUser
            self.navigationController?.pushViewController(objVC, animated: true)
            }
        }
    }
}

extension EmailVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
