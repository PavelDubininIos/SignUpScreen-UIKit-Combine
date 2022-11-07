//
//  ViewController.swift
//  SignUpScreen-UIKit-Combine
//
//  Created by Павел Дубинин on 07.11.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmationField: UITextField!
    @IBOutlet weak var agreeTermsSwitch: UISwitch!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

