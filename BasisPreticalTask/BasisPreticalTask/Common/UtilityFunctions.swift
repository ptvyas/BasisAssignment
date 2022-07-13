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
