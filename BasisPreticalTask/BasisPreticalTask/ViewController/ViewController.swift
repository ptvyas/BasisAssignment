//
//  ViewController.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        runAfterTime(time: 1.0) {
            guard let objVC = loadVC(strStoryboardId: STORYBOARD.Main, strVCId: "EmailVC") as? EmailVC else { return }
            self.navigationController?.pushViewController(objVC, animated: false)
        }
    }
}

