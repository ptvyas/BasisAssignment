//
//  HomeVC.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import UIKit

class HomeVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var txtReferName: UITextField!
    
    //MARK: - Variables
    var objLoginUserRes : LoginUserRes?
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fillValue()
    }
    
    //MARK: - Button action
    @IBAction func btnReferAction(_ sender: UIButton) {
        let referVal : String = (self.txtReferName.text ?? "").trim()
        
        if referVal.isEmpty {
            showAlertMessage(nil, APP_MESSAGE.enterReferName, onViewController: self)
            return
        }
        
        showLoader()
        UtilityHTTPS().referNow(withCode: referVal) { objError, isSuccess, message, objUserInfo in
//            print("objError: \(objError)")
//            print("message: \(message)")
//            print("objUserInfo: \(objUserInfo?.firstName)")
            
            hideLoader()
            runOnMainThread {
            if let objError = objError {
                showAlertMessage(nil, objError.localizedDescription, onViewController: self)
                return
            }
            
            var vMessge : String = message ?? [APP_MESSAGE.somethingWrong, APP_MESSAGE.pleaseTryAgain].joined(separator: "\n")
            if !isSuccess {
                showAlertMessage(nil, vMessge, onViewController: self)
                return
            }
            if let objUser = objUserInfo  {
                vMessge += "\n Hello \(objUser.getFullName())"
                showAlertMessage(nil, vMessge, onViewController: self)
                return
            }
            showAlertMessage(nil, vMessge, onViewController: self)
            }
        }
    }
}
extension HomeVC {
    func fillValue() {
        var vName : String = ""
        var vMess : String = ""
        
        if let objUser = self.objLoginUserRes {
            vName = [objUser.firstName, objUser.lastName].joined(separator: " ")
            
            vMess = "Other Info \n\n"
            vMess += ["Email: ", objUser.email].joined(separator: " ") + "\n\n"
            vMess += ["Phone Number: ", objUser.phoneNumber].joined(separator: " ") + "\n\n"
            vMess += ["Rewards: ", objUser.rewards.description].joined(separator: " ") + "\n\n"
        }
        self.lblUser.text = vName
        self.lblMessage.text = vMess
    }
}
