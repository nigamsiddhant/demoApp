//
//  AddTaskViewController.swift
//  DemoApp
//
//  Created by admin_vserv on 07/12/20.
//

import UIKit

protocol AddTask {
    func addTask(task: Task)
}

class AddTaskViewController: UIViewController {

    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var delegate: AddTask?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupview()
        // Do any additional setup after loading the view.
    }
    
    private func setupview() {
        let arrayofViews = [clearButton,dateTextField,taskTextField,saveButton]
        AppUtilities.shared.border(views: arrayofViews)
        
        
        
        self.dateTextField.inputView = self.datePicker
        self.dateTextField.inputAccessoryView = self.toolBar
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateWithCurrentLang()
    }
    
    private func updateWithCurrentLang(){
        let currentLang = AppController.shared.currentLanguage
        self.navigationController?.navigationBar.topItem?.title = "Add Task"
        tabBarController?.tabBar.items?[0].title = "encryption".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[1].title = "toDo".localizableString(loc: currentLang ?? "en")
        tabBarController?.tabBar.items?[2].title = "stopWatch".localizableString(loc: currentLang ?? "en")

        let taskPlaceHolder = "taskName".localizableString(loc: currentLang ?? "en")
        let datePlaceHolder = "dateAndTime".localizableString(loc: currentLang ?? "en")
        let saveButtonText = "save".localizableString(loc: currentLang ?? "en")
        let clearButtonText = "clear".localizableString(loc: currentLang ?? "en")
        
        
        self.dateTextField.attributedPlaceholder = NSAttributedString(string: datePlaceHolder,
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        self.taskTextField.attributedPlaceholder = NSAttributedString(string: taskPlaceHolder,
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.saveButton.setTitle(saveButtonText, for: .normal)
        self.clearButton.setTitle(clearButtonText, for: .normal)
        
        
    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy h:mm a"
        self.dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        self.dateTextField.resignFirstResponder()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if self.taskTextField.text?.count == 0 {
            print("please enter text")
        }
        else if self.dateTextField.text?.count == 0 {
            print("please enter date")
        }
        else {
            delegate?.addTask(task: Task(taskName: self.taskTextField.text, taskDate: self.dateTextField.text))
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        self.taskTextField.text = ""
        self.dateTextField.text = ""
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
