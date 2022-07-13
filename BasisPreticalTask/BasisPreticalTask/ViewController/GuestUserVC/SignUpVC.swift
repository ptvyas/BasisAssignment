//
//  SignOutVC.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import UIKit

class SignUpVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var lblEmail: UILabel!
    
    //MARK: - Variables
    var userEmail = String()
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialize()
    }
    
    // MARK: - Button action method
    @IBAction func btnContinueAction(_ sender: UIButton) {
        hideKeyboard(self)
        showAlertMessage(nil, APP_MESSAGE.onWorkingProgress, onViewController: self)
    }
}

extension SignUpVC {
    func initialize() {
        self.lblEmail.text = self.userEmail.trim()
    }
}
