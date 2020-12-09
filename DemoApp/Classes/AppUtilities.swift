//
//  AppUtilities.swift
//  DemoApp
//
//  Created by admin_vserv on 07/12/20.
//

import Foundation
import UIKit

public class AppUtilities {
    
    static var shared = AppUtilities()
    
    public func border(views: [Optional<UIView>]) {
        for view in views {
            view?.layer.borderWidth = 1
            view?.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    public func borderAndCornerRadius(views: [Optional<UIView>]) {
        for view in views {
            view?.layer.borderWidth = 2
            view?.layer.borderColor = UIColor.black.cgColor
            view?.clipsToBounds = true
            view?.layer.cornerRadius = (view?.frame.width)!/2
        }
        
    }
}
