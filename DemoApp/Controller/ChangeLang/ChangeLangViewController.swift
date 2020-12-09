//
//  ChangeLangViewController.swift
//  DemoApp
//
//  Created by admin_vserv on 07/12/20.
//

import UIKit

class ChangeLangViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tbleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tbleView: UITableView!
    let lang = ["English","Arabic"]
    var selectedLang = [0,0]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if selectedLang[0] == 1{
            AppController.shared.currentLanguage = "en"
        }
        if selectedLang[1] == 1{
            AppController.shared.currentLanguage = "ar"
        }
        updateWithCurrentLang()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateWithCurrentLang()
    }
    
    private func setupView() {

        DispatchQueue.main.async {
            self.tbleView.separatorStyle = .none
            self.tbleViewHeight.constant = 80
            AppUtilities.shared.border(views: [self.saveButton])
            if AppController.shared.currentLanguage == "en"{
                self.selectedLang[0] = 1
                self.selectedLang[1] = 0
            }
            else {
                self.selectedLang[0] = 0
                self.selectedLang[1] = 1
            }
            self.tbleView.reloadData()
        }
    }
    
    private func updateWithCurrentLang(){
        let currentLang = AppController.shared.currentLanguage
        
        tabBarController?.tabBar.items?[0].title = "encryption".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[1].title = "toDo".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[2].title = "stopWatch".localizableString(loc: currentLang ?? "en")
        
        let saveButtonText = "save".localizableString(loc: currentLang ?? "en")
        self.saveButton.setTitle(saveButtonText, for: .normal)
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
        let roundedView = cell?.viewWithTag(1) as? UIView
        let lbl = cell?.viewWithTag(2) as? UILabel
        lbl?.text = lang[indexPath.row]
        
        if self.selectedLang[indexPath.row] == 1 {
            roundedView?.backgroundColor = .black
        }
        else {
            roundedView?.backgroundColor = .white
        }
        AppUtilities.shared.borderAndCornerRadius(views: [roundedView])
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.selectedLang[0] = 1
            self.selectedLang[1] = 0
        }
        else {
            self.selectedLang[0] = 0
            self.selectedLang[1] = 1
        }
        self.tbleView.reloadData()
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
