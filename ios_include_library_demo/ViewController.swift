//
//  ViewController.swift
//  ios_include_library_demo
//
//  Created by codexpedia on 1/27/19.
//  Copyright © 2019 codexpedia. All rights reserved.
//

import UIKit
import SDWebImage // import the image library so it can be used in this class
import Alamofire  // import the network library so it can be used in this class

class ViewController: UIViewController {
    
    // The outlet that connects to the ImageView on the storyboard
    @IBOutlet weak var imageView: UIImageView!
    
    // The outlet that connects to the TextField on the storyboard
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the image from an image url
        imageView.sd_setImage(with: URL(string: "https://images.freeimages.com/images/large-previews/e71/frog-1371919.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
        
        makeGetRequestWithAlamofire()
    }
    
    
    func makeGetRequestWithAlamofire() {
        Alamofire.request("https://api.github.com/users/google")
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("error calling GET")
                    print(response.result.error!)
                    return
                }
                
                guard let json = response.result.value as? [String: Any] else {
                    print("Expected JSON data, but non JSON data returned from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                print(json)
                
                guard let name = json["name"] as? String else {
                    print("Could not get name from JSON")
                    return
                }
                
                guard let email = json["email"] as? String else {
                    print("Could not get email from JSON")
                    return
                }

                print("The name is: \(name), email is: \(email)")
                self.textView.text = name + "\r" + email //"\(name)\n\(email)"
        }
    }
    
}

