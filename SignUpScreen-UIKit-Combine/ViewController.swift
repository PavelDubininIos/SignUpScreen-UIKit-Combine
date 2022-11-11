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
    
    private var cancellables: Set<AnyCancellable> = []
    
    //MARK: - Outlets
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmationField: UITextField!
    @IBOutlet weak var agreeTermsSwitch: UISwitch!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formIsValid
            .assign(to: \.isEnabled, on: signUpButton)
            .store(in: &cancellables)
        
        setValidColor(field: emailAddressField, publisher: emailIsValid)
        setValidColor(field: passwordConfirmationField, publisher: passwordValidConfirmed)
        setValidColor(field: passwordField, publisher: passwordIsvalid)
    }
    
    private func setValidColor<P: Publisher>(field: UITextField, publisher: P)
    where P.Output == Bool, P.Failure == Never {
        publisher
            .map { $0 ? UIColor.label : UIColor.systemRed }
            .assign(to: \.textColor, on: field)
            .store(in: &cancellables)
    }

    private func isEmailIsValid(_ email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }
    
    //MARK: - Publishers
    
    private var formIsValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(emailIsValid, passwordValidConfirmed, agreeTermSubject)
            .map {
                $0.0 && $0.1 && $0.2
            }
            .eraseToAnyPublisher()
    }
    
    private var passwordValidConfirmed: AnyPublisher<Bool, Never> {
        passwordIsvalid.combineLatest(passwordMatchesConformation)
            .map { valid, confirmed in
                valid && confirmed
            }
            .eraseToAnyPublisher()
    }
    
    private var passwordIsvalid: AnyPublisher<Bool, Never> {
        passwordSubject
            .map {
                $0 != "password" && $0.count >= 8
            }
            .eraseToAnyPublisher()
    }
    
    private var passwordMatchesConformation: AnyPublisher<Bool, Never> {
        passwordSubject.combineLatest(passwordConfirmationSubject)
            .map { password, conformation in
                password == conformation
            }
            .eraseToAnyPublisher()
    }
    
    private var emailIsValid: AnyPublisher<Bool, Never> {
        emailSubject
            .map { [weak self] in self?.isEmailIsValid($0) }
            .replaceNil(with: false)
            .eraseToAnyPublisher()
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

