//
//  AddPlantViewController.swift
//  home
//
//  Created by 황수비 on 2023/05/27.
//

import Foundation
import UIKit
import PanModal

class AddPlantViewController: UIViewController{
    
    @IBOutlet weak var plantType: UITextField!
    @IBOutlet weak var plantNickname: UITextField!
    
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
    
//    let picker = UIDatePicker()
    let birthdatePicker = UIDatePicker()
    let waterdatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantType.borderStyle = .roundedRect
        plantType.layer.cornerRadius = 10.0
        plantType.borderStyle = .none
        
        plantNickname.borderStyle = .roundedRect
        plantNickname.layer.cornerRadius = 10.0
        plantNickname.borderStyle = .none
        
        birthTextField.borderStyle = .roundedRect
        birthTextField.layer.cornerRadius = 10.0
        birthTextField.borderStyle = .none
        
        setupBirthTextField()
        setupBirthToolBar()
        setupBirthDatePicker()
        
        waterTextField.borderStyle = .roundedRect
        waterTextField.layer.cornerRadius = 10.0
        waterTextField.borderStyle = .none
        
        setupWaterTextField()
        setupWaterToolBar()
        setupWaterDatePicker()
    }
    
    //나중에 검색 뷰로 바꾸기!!
    @IBAction func goSearchView(_ sender: Any) {
        guard let SearchViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        SearchViewController.modalTransitionStyle = .crossDissolve
        SearchViewController.modalPresentationStyle = .fullScreen
        self.present(SearchViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func goCharacterViewController(_ sender: UIButton) {
        let characterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: AddCharacterViewController.self)) as! AddCharacterViewController
        presentPanModal(characterVC)
    }
    
    func gotoMainView() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true) // 현재 뷰 컨트롤러를 dismiss하여 이전 뷰 컨트롤러로 돌아감
        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "NaviagationController") as? UINavigationController else { return }
        homeVC.modalTransitionStyle = .coverVertical
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: true, completion: nil)
    }
    
    @IBAction func gotoMainView(_ sender: Any) {
        self.gotoMainView()
    }
    
    
    @IBAction func goBack(_ sender: UIButton) {
        guard let goBack = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        goBack.modalTransitionStyle = .crossDissolve
        goBack.modalPresentationStyle = .fullScreen
        self.present(goBack, animated: true, completion: nil)
    }
    
}

//birthdatePicker
extension AddPlantViewController{
    
    private func setupBirthDatePicker() {
           // datePickerModed에는 time, date, dateAndTime, countDownTimer가 존재
        birthdatePicker.datePickerMode = .date
           // datePicker 스타일을 설정합니다. wheels, inline, compact, automatic이 존재합니다.
        birthdatePicker.preferredDatePickerStyle = .wheels
        birthdatePicker.locale = Locale(identifier: "ko-KR")
           // 값이 변할 때마다 동작을 설정
        birthdatePicker.addTarget(self, action: #selector(birthDateChange), for: .valueChanged)
           // nil이면 키보드 기본 할당
        birthTextField.inputView = birthdatePicker
           // brithTextField에 오늘 날짜로 표시되게 설정
        birthTextField.text = birthDateFormat(date: Date())
       }
    
      // 값이 변할 때 마다 동작
        @objc func birthDateChange(_ sender: UIDatePicker) {
            // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 입력
            birthTextField.text = birthDateFormat(date: sender.date)
        }
        
        // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
        private func birthDateFormat(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy / MM / dd"
            
            return formatter.string(from: date)
        }

        // 툴바 세팅
        private func setupBirthToolBar() {
            
            let toolBar = UIToolbar()

            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBirthButtonHandeler))

            toolBar.items = [flexibleSpace, doneButton]
            toolBar.sizeToFit()

            // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시
            // 현재 inputView를 datePicker로 만들어 줬으니 datePicker위에 표시됨
            birthTextField.inputAccessoryView = toolBar
        }
        
        @objc func doneBirthButtonHandeler(_ sender: UIBarButtonItem) {
            birthTextField.text = birthDateFormat(date: birthdatePicker.date)
            // 키보드 내리기
            birthTextField.resignFirstResponder()
        }
        
        private func setupBirthTextField() {
            view.addSubview(birthTextField)
        }
    
}

//waterdatePicker
extension AddPlantViewController{

    private func setupWaterDatePicker() {
        waterdatePicker.preferredDatePickerStyle = .wheels
        waterdatePicker.locale = Locale(identifier: "ko-KR")
        waterdatePicker.addTarget(self, action: #selector(waterDateChange), for: .valueChanged)
        waterTextField.inputView = waterdatePicker
           // brithTextField에 오늘 날짜로 표시되게 설정
        waterTextField.text = waterDateFormat(date: Date())
       }
    
    // 값이 변할 때 마다 동작
        @objc func waterDateChange(_ sender: UIDatePicker) {
            // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 입력
            waterTextField.text = waterDateFormat(date: sender.date)
        }
        
        // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
        private func waterDateFormat(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy / MM / dd HH:mm"
            
            return formatter.string(from: date)
        }

        private func setupWaterToolBar() {
            
            let toolBar = UIToolbar()

            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneWaterButtonHandeler))

            toolBar.items = [flexibleSpace, doneButton]
            toolBar.sizeToFit()

            // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시
            // 현재 inputView를 datePicker로 만들어 줬으니 datePicker위에 표시됨
            waterTextField.inputAccessoryView = toolBar
        }
        
        @objc func doneWaterButtonHandeler(_ sender: UIBarButtonItem) {
            waterTextField.text = waterDateFormat(date: waterdatePicker.date)
            waterTextField.resignFirstResponder()
        }
        
        private func setupWaterTextField() {
            view.addSubview(waterTextField)
        }
    
}

