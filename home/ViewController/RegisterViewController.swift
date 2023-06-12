//
//  RegisterViewController.swift
//  home
//
//  Created by 황수비 on 2023/05/27.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var PasswordCheckField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        EmailTextField.borderStyle = .roundedRect
        EmailTextField.layer.cornerRadius = 10.0
        EmailTextField.borderStyle = .none
        EmailTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        PasswordTextField.borderStyle = .roundedRect
        PasswordTextField.layer.cornerRadius = 10.0
        PasswordTextField.borderStyle = .none
        
        PasswordCheckField.borderStyle = .roundedRect
        PasswordCheckField.layer.cornerRadius = 10.0
        PasswordCheckField.borderStyle = .none
        
        PasswordTextField.isSecureTextEntry = true
        PasswordCheckField.isSecureTextEntry = true
        
        warningLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        warningLabel.textColor = UIColor.red

    }
    
    func showWarning(message: String) {
           warningLabel.text = message
           warningLabel.isHidden = false
    }
    
    @IBAction func pressRegisterButton(_ sender: Any) {
        guard let email = EmailTextField.text, !email.isEmpty else {
                showWarning(message: "이메일을 입력해주세요.")
                return
            }
        guard let password = PasswordTextField.text, !password.isEmpty else {
                showWarning(message: "비밀번호 확인을 입력해주세요.")
                return
            }
        guard let passwordCheck = PasswordCheckField.text, !passwordCheck.isEmpty else {
                showWarning(message: "비밀번호 확인을 입력해주세요.")
                return
            }
            
            if password != passwordCheck {
                showWarning(message: "비밀번호가 다릅니다")
                return
            }
        
        UserAPI.Register()
        
        // 입력이 모두 유효한 경우에만 다음 뷰로 이동
        guard let AddPlantViewController = storyboard?.instantiateViewController(withIdentifier: "AddPlantViewController") as? AddPlantViewController else {
                return
            }
            AddPlantViewController.modalTransitionStyle = .crossDissolve
            AddPlantViewController.modalPresentationStyle = .fullScreen
            present(AddPlantViewController, animated: true, completion: nil)
        
        print(email)
        print(password)
        
    }
    
}
