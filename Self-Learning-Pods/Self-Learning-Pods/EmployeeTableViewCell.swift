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
    
    func configureCell(data: EmployeeModel?) {
        empName.text = data?.employeeName
        empSalary.text = data?.employeeSalary
        empAge.text = data?.employeeAge
    }
}
