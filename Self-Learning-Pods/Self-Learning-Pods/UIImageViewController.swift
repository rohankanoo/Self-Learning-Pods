//
//  UIImageViewController.swift
//  Self-Learning-Pods
//
//  Created by Rohan Kanoo on 20/04/20.
//  Copyright © 2020 Rohan Kanoo. All rights reserved.
//

import UIKit
import Alamofire

class UIImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let remoteImageURL = URL(string: "https://i.picsum.photos/id/237/300/300.jpg")
        Alamofire.request(remoteImageURL!).responseData { response in
            if response.error == nil {
                if let imageData = response.data {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
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
