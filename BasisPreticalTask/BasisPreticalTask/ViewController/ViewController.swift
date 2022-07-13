//
//  ViewController.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loader Setup
        SVProgressHUD.setForegroundColor(UIColor.lightGray.withAlphaComponent(0.5))
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setBorderColor(UIColor.red)
        
        runAfterTime(time: 1.0) {
            guard let objVC = loadVC(strStoryboardId: STORYBOARD.Main, strVCId: "EmailVC") as? EmailVC else { return }
            self.navigationController?.pushViewController(objVC, animated: false)
        }
    }
}

