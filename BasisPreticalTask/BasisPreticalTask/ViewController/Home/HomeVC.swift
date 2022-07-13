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
    
    //MARK: - Variables
    var objLoginUserRes : LoginUserRes?
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fillValue()
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
