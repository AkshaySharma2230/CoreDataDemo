//
//  CoreValueTableViewCell.swift
//  CoreDataDemo
//
//  Created by apple on 02/11/21.
//

import UIKit

class CoreValueTableViewCell: UITableViewCell {

    //MARK:- Cell Outlets
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var dateNameLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    //MARK:- AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    //MARK:- SetSelected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
