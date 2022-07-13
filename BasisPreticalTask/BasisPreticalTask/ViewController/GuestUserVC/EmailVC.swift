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
        
        // Do any additional setup after loading the view.
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
        
        UtilityHTTPS().checkUser_Email(withEmail: vEmail) { objError, arrUser in
            print("objError: \(objError)")
            print("arrUser: \(arrUser)")
        }
        //guard let objVC = loadVC(strStoryboardId: STORYBOARD.Main, strVCId: "EmailVarificationVC") as? EmailVarificationVC else { return }
        //self.navigationController?.pushViewController(objVC, animated: true)
    }
}

extension EmailVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
