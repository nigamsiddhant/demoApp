//
//  AppController.swift
//  DemoApp
//
//  Created by admin_vserv on 09/12/20.
//

import Foundation
import UIKit

class AppController {
    
    static var shared = AppController()
    
    var userName: String? {
        get {
            if let returnValue = UserDefaults.standard.object(forKey: "userName") as? String {
                return returnValue
            } else {
                return nil
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userName")
            UserDefaults.standard.synchronize()
        }
    }
    
    var currentLanguage: String? {
        get {
            if let returnValue = UserDefaults.standard.object(forKey: "currentLanguage") as? String {
                return returnValue
            } else {
                return "en"
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentLanguage")
            UserDefaults.standard.synchronize()
        }
    }
}
