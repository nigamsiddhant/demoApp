//
//  AppDelegate.swift
//  DemoApp
//
//  Created by admin_vserv on 07/12/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
@main

class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    
    var window: UIWindow?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error { print(error.localizedDescription); return }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print("error while loging\(error)")
                return
            }
            guard let user = user?.user else { return }
            AppController.shared.userName = user.displayName
            self.showHomeScreen()
        }
    }
    
    private func showHomeScreen() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        
        let viewController = sb.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        if AppController.shared.userName != nil {
            self.showHomeScreen()
        }
        else {
            print("normal screen")
        }
        return true
    }

    
}

