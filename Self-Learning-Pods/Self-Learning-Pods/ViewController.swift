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
    var data: [APIResponseModel]?
}

struct APIResponseModel: Codable {
    var employee_name: String?
    var id: String?
    var employee_salary: String?
    var employee_age: String?
    
    private enum CodingKeys : String, CodingKey {
        case employee_name
        case id
        case employee_salary
        case employee_age
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var responseModel: BaseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib.init(nibName: "EmployeeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EmployeeTableViewCell")
        // Do any additional setup after loading the view.
        Alamofire.request("https://dummy.restapiexample.com/api/v1/employees", method: .get, parameters: nil, encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { [weak self] response in
//                switch response.result {
//                case .failure(let error):
//                    print(error)
//                case .success(let data):
//                    do {
//                        let decoder = JSONDecoder()
//                        decoder.keyDecodingStrategy = .convertFromSnakeCase
//                        let result = try decoder.decode(BaseModel.self, from: result)
//                        self?.responseModel = result
//                    } catch { print(error) }
//                }
                guard let result = response.result.value else {
                    return
                }
//                print(result)
//                self?.modelArray = result
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let result = try decoder.decode(BaseModel.self, from: result)
                    self?.responseModel = result
                } catch { print(error) }
                self?.tableView.reloadData()
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
}
