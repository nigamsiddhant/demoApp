//
//  StopWatchViewController.swift
//  DemoApp
//
//  Created by admin_vserv on 07/12/20.
//

import UIKit

class StopWatchViewController: UIViewController {
    
    var sec = 0
    var min = 0
    var hr = 0
    var timer = Timer()
    var isPlaying = false
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupview()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateWithCurrentLang()
    }
    
    private func setupview() {
        self.navigationController?.navigationBar.topItem?.title = "Welcome \(AppController.shared.userName ?? "")"
        let arrayofViews = [timerView]
        AppUtilities.shared.borderAndCornerRadius(views: arrayofViews)
        timeLabel.text = "0:0:0"
    }
    
    private func updateWithCurrentLang(){
        let currentLang = AppController.shared.currentLanguage
        let welcome = "welcome".localizableString(loc: currentLang ?? "en")
        self.navigationController?.navigationBar.topItem?.title = welcome + " " + AppController.shared.userName!
        tabBarController?.tabBar.items?[0].title = "encryption".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[1].title = "toDo".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[2].title = "stopWatch".localizableString(loc: currentLang ?? "en")
    }
    
    @IBAction func stopAction(_ sender: Any) {
        
        timer.invalidate()
        isPlaying = false
        timeLabel.text = "0:0:0"
        sec = 0
        min = 0
        hr = 0
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        
        timer.invalidate()
        isPlaying = false
    }
    
    @IBAction func playAction(_ sender: Any) {
        if(isPlaying) {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @objc func UpdateTimer() {
        sec = sec + 1
        if sec == 60 {
            sec = 0
            min = min + 1
        }
        if min == 60 {
            min = 0
            hr = hr + 1
        }
        
        timeLabel.text = "\(hr):\(min):\(sec)"
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
