//
//  ViewController.swift
//  home
//
//  Created by 황수비 on 2023/05/26.
//

import UIKit

class LoginViewController: UIViewController {
    
    //로그인 변수
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmailTextField.borderStyle = .roundedRect
        EmailTextField.layer.cornerRadius = 10.0
        EmailTextField.borderStyle = .none
        
        PasswordTextField.borderStyle = .roundedRect
        PasswordTextField.layer.cornerRadius = 10.0
        PasswordTextField.borderStyle = .none
        
        PasswordTextField.isSecureTextEntry = true
        
        warningLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        warningLabel.textColor = UIColor.red
    }
    
    func showWarning(message: String) {
           warningLabel.text = message
           warningLabel.isHidden = false
    }
    
    func gotoHomeView(){
        self.presentingViewController?.dismiss(animated: true)
        guard let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "NaviagationController") as? UINavigationController else { return }
                HomeVC.modalTransitionStyle = .coverVertical
                HomeVC.modalPresentationStyle = .fullScreen
                self.present(HomeVC, animated: true, completion: nil)
    }
    

    @IBAction func pressLoginBtn(_ sender: Any) {
        
        guard let email = EmailTextField.text, !email.isEmpty else {
                showWarning(message: "이메일을 입력해주세요.")
                return
            }
        guard let password = PasswordTextField.text, !password.isEmpty else {
                showWarning(message: "비밀번호를 입력해주세요.")
                return
            }
        self.gotoHomeView()
//        let loginRequest = LoginRequest(email: email, password: password)
//
//        UserAPI.Login(request: loginRequest) { auth, error in
//               if let auth = auth {
//                   // 로그인 성공한 경우 홈 뷰로 이동
//                   self.gotoHomeView()
//               } else {
//                   // 로그인 실패한 경우 경고창 출력
//                   self.showWarning(message: "가입되지 않은 계정입니다.")
//               }
//        }
        
    }
    
    
    @IBAction func pressRegisterBtn(_ sender: Any) {
 
        guard let RegisterViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        RegisterViewController.modalTransitionStyle = .crossDissolve
        RegisterViewController.modalPresentationStyle = .fullScreen
        self.present(RegisterViewController, animated: true, completion: nil)
        
    }


}

