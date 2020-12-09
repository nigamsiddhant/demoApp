//
//  ToDoTableViewCell.swift
//  DemoApp
//
//  Created by admin_vserv on 07/12/20.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var taskName: UILabel!
    var task: Task? {
        didSet {
            self.dateLabel.text = task?.taskDate
            self.taskName.text = task?.taskName
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
