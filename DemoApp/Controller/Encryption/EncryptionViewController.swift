//
//  EncryptionViewController.swift
//  DemoApp
//
//  Created by admin_vserv on 07/12/20.
//

import UIKit
import CryptoSwift
import RNCryptor
import Foundation

class EncryptionViewController: UIViewController {

    @IBOutlet weak var encryptedanddecryptedText: UITextView!
    @IBOutlet weak var decryptedButton: UIButton!
    @IBOutlet weak var encryptedButton: UIButton!
    @IBOutlet weak var secureText: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateWithCurrentLang()
    }
    
    private func setupView() {
        let arrayofViews = [messageTextView,secureText,encryptedButton,decryptedButton]
        AppUtilities.shared.border(views: arrayofViews)
        
        
    }
    
    private func updateWithCurrentLang(){
        let currentLang = AppController.shared.currentLanguage
        self.messageTextView.text = "message".localizableString(loc: currentLang ?? "en")
        let welcome = "welcome".localizableString(loc: currentLang ?? "en")
        self.navigationController?.navigationBar.topItem?.title = welcome + " " + AppController.shared.userName!
        self.encryptedButton.setTitle("encrypt".localizableString(loc: currentLang ?? "en"), for: .normal)
        self.decryptedButton.setTitle("decrypt".localizableString(loc: currentLang ?? "en"), for: .normal)
        
        let securePlaceHolder = "secretKey".localizableString(loc: currentLang ?? "en")
        self.secureText.attributedPlaceholder = NSAttributedString(string: securePlaceHolder,
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        tabBarController?.tabBar.items?[0].title = "encryption".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[1].title = "toDo".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[2].title = "stopWatch".localizableString(loc: currentLang ?? "en")
    }
    
    @IBAction func encryptPressed(_ sender: UIButton) {
        encryptString()
    }
    
    @IBAction func decryptPressed(_ sender: UIButton) {
        decryptString()
    }
    
    private func encryptString(){
        let input = messageTextView!.text
        let key = secureText.text!
        let iv = "gqLOHUioQ0QjhuvI"
        let en = try! input?.aesEncrypt(key: key, iv: iv)
        self.encryptedanddecryptedText.text = en
    }
    
    private func decryptString(){
        let input = messageTextView!.text
        let key = secureText.text!
        let iv = "gqLOHUioQ0QjhuvI"
        let en = try! input?.aesDecrypt(key: key, iv: iv)
        self.encryptedanddecryptedText.text = en
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

extension EncryptionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.messageTextView.text = ""
    }
}

extension String {
    func aesEncrypt(key: String, iv: String) throws -> String{
        let encrypted = try AES(key: key, iv: iv, padding: .pkcs7).encrypt([UInt8](self.data(using: .utf8)!))
            return Data(encrypted).base64EncodedString()
    }

    func aesDecrypt(key: String, iv: String) throws -> String {
        guard let data = Data(base64Encoded: self) else { return "" }
            let decrypted = try AES(key: key, iv: iv, padding: .pkcs7).decrypt([UInt8](data))
            return String(bytes: decrypted, encoding: .utf8) ?? self
    }
}


extension String {
    func localizableString(loc: String) -> String {
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
