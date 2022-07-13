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
    
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    // MARK: - Button action method
    @IBAction func btnBackAction(_ sender: UIButton) {
        hideKeyboard(self)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnResetOTPAction(_ sender: UIButton) {
        hideKeyboard(self)
        showAlertMessage(nil, APP_MESSAGE.Resend_OPT_Success, onViewController: self)
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        hideKeyboard(self)
        
        guard let objVC = loadVC(strStoryboardId: STORYBOARD.Main, strVCId: "EmailVarificationVC") as? EmailVarificationVC else { return }
        self.navigationController?.pushViewController(objVC, animated: true)
    }
}

extension EmailVarificationVC {
     func initialize() {
         OTPView.style = .box
         OTPView.becomeFirstResponderAtIndex = 0
    }
}
