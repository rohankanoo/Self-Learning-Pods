//
//  ViewController.swift
//  Self-Learning-Pods
//
//  Created by Rohan Kanoo on 19/04/20.
//  Copyright © 2020 Rohan Kanoo. All rights reserved.
//

import UIKit
import Alamofire

struct BaseModel: Codable {
    var status: String?
    var data: [EmployeeModel]?
}

struct EmployeeModel: Codable {
    var id: String?
    var employeeName: String?
    var employeeSalary: String?
    var employeeAge: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var responseModel: BaseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        registerTableViewCells()
        getEmployeeData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerTableViewCells() {
        let nib = UINib.init(nibName: "EmployeeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EmployeeTableViewCell")
    }
    
    private func getEmployeeData() {
        // Show spinner
        Alamofire.request("https://dummy.restapiexample.com/api/v1/employees", method: .get, parameters: nil, encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { [weak self] response in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let result = try decoder.decode(BaseModel.self, from: data)
                        self?.responseModel = result
                        print(result)
                    } catch { print(error) }
                }
                
                self?.tableView.reloadData()
                // Stop Spinner
        }
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell") as? EmployeeTableViewCell {
            cell.configureCell(data: responseModel?.data?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UIImageViewController")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
