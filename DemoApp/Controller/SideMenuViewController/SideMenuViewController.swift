//
//  SideMenuViewController.swift
//  DemoApp
//
//  Created by admin_vserv on 07/12/20.
//

import UIKit
import Firebase
import GoogleSignIn

class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let list = ["changeLanguage".localizableString(loc: AppController.shared.currentLanguage ?? ""),"logout".localizableString(loc: AppController.shared.currentLanguage ?? "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    private func showAlert(){
        let currentLang = AppController.shared.currentLanguage

        let messageText = "areyousuretologout".localizableString(loc: currentLang ?? "")
        let okText = "ok".localizableString(loc: currentLang ?? "en")
        let cancelText = "cancel".localizableString(loc: currentLang ?? "en")
        let alert = UIAlertController(title: nil, message: messageText, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: okText, style: .destructive) { (action) in
            GIDSignIn.sharedInstance()?.signOut()
            AppController.shared.userName = nil
            self.showHomeScreen()
        }
        let cancelAction = UIAlertAction.init(title: cancelText, style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.selectionStyle = .none
        let lbl = cell?.viewWithTag(1) as! UILabel
        lbl.text = list[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 0{
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let addTaskVc: ChangeLangViewController = sb.instantiateViewController(withIdentifier: "ChangeLangViewController") as! ChangeLangViewController
            self.navigationController?.pushViewController(addTaskVc, animated: true)
        }
        else {
            self.showAlert()
        }
    }
    
    private func showHomeScreen() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        
        let viewController: ViewController = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
