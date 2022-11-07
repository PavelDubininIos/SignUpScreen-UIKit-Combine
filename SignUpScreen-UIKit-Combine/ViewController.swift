//
//  ViewController.swift
//  SignUpScreen-UIKit-Combine
//
//  Created by Павел Дубинин on 07.11.2022.
//

import UIKit
import Combine

class ViewController: UITableViewController {
    
    //MARK: - Subjects
    
    private var emailSubject = CurrentValueSubject<String, Never>("")
    private var passwordSubject = CurrentValueSubject<String, Never>("")
    private var passwordConfirmationSubject = CurrentValueSubject<String, Never>("")
    private var agreeTermSubject = CurrentValueSubject<Bool, Never>(false)
    
    //MARK: - Outlets
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmationField: UITextField!
    @IBOutlet weak var agreeTermsSwitch: UISwitch!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions

    @IBAction func emailDidChange(_ sender: Any) {
        emailSubject.send(emailAddressField.text ?? "")
    }
    
    @IBAction func passwordDidChange(_ sender: Any) {
        passwordSubject.send(passwordField.text ?? "")
    }
    
    @IBAction func passwordConfirmationDidChange(_ sender: Any) {
        passwordConfirmationSubject.send(passwordConfirmationField.text ?? "")
    }
    
    @IBAction func agreeSwitchDidChange(_ sender: Any) {
        agreeTermSubject.send(agreeTermsSwitch.isOn)
    }
}

