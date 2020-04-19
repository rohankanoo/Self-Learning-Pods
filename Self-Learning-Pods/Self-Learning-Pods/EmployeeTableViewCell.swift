//
//  EmployeeTableViewCell.swift
//  Self-Learning-Pods
//
//  Created by Rohan Kanoo on 19/04/20.
//  Copyright © 2020 Rohan Kanoo. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var empSalary: UILabel!
    @IBOutlet weak var empAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(data: APIResponseModel?) {
        empName.text = data?.employee_name
        empSalary.text = data?.employee_salary
        empAge.text = data?.employee_age
    }
}
