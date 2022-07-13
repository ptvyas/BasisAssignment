//
//  UtilityFunctions.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation
import UIKit

//MARK: -  Get VC
public func getStoryboard(storyboardName: String) -> UIStoryboard {
    return UIStoryboard(name: storyboardName, bundle: nil)
}

public func loadVC(strStoryboardId: String, strVCId: String) -> UIViewController {
    let vc = getStoryboard(storyboardName: strStoryboardId).instantiateViewController(withIdentifier: strVCId)
    return vc
}

//MARK: - Alert
func showAlertMessage(_ vTitle : String?,
                      _ vMessage: String,
                      okButtonTitle: String = "OK",
                      onViewController: UIViewController?,
                      onClickAction:((UIAlertAction) -> Void)? = nil) -> Void {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: (vTitle ?? "").isEmpty ? nil : vTitle,
                                      message: vMessage,
                                      preferredStyle: .alert)
        
        let btnAction = UIAlertAction.init(title: okButtonTitle, style: .default) { (action) in
            onClickAction?(action)
        }
        alert.addAction(btnAction)
        
        onViewController?.present(alert, animated: true, completion: nil)
    }
}

//MARK: -
/// Hide Keyboard
public func hideKeyboard(_ onViewController : UIViewController?) {
    onViewController?.view.endEditing(true)
}
