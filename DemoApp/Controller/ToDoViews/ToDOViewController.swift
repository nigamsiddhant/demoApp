//
//  ToDOViewController.swift
//  DemoApp
//
//  Created by admin_vserv on 07/12/20.
//

import UIKit

class ToDOViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var task: [Task] = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
    }
    
    
    private func setupView() {
        self.task.removeAll()
        self.tableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")
        self.tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateWithCurrentLang()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func updateWithCurrentLang(){
        let currentLang = AppController.shared.currentLanguage
        let welcome = "welcome".localizableString(loc: currentLang ?? "en")
        self.navigationController?.navigationBar.topItem?.title = welcome + " " + AppController.shared.userName!
        tabBarController?.tabBar.items?[0].title = "encryption".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[1].title = "toDo".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[2].title = "stopWatch".localizableString(loc: currentLang ?? "en")
    }
    
    private func showAlert(title: String?,message:String?,indexPath: IndexPath,actionOneText: String,actionTwoText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: actionOneText, style: .destructive) { (action) in
            print("Yes Action")
            self.task.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let noAction = UIAlertAction(title: actionTwoText, style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addTaskAction(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let addTaskVc: AddTaskViewController = sb.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        addTaskVc.delegate = self
        self.navigationController?.pushViewController(addTaskVc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ToDoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell") as! ToDoTableViewCell
        cell.task = self.task[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let currentLang = AppController.shared.currentLanguage
        let deleteText = "delete".localizableString(loc: currentLang ?? "en")
        let sureText = "surewantTodelete".localizableString(loc: currentLang ?? "en")
        let okText = "ok".localizableString(loc: currentLang ?? "en")
        let cancelText = "cancel".localizableString(loc: currentLang ?? "en")
        if editingStyle == .delete {
            self.showAlert(title: deleteText, message: sureText, indexPath: indexPath, actionOneText: okText, actionTwoText: cancelText)
        }
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

extension ToDOViewController: AddTask {
    func addTask(task: Task) {
        self.task.append(task)
        self.tableView.reloadData()
    }
}
