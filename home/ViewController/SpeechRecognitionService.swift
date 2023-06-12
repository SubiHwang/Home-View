//
//  SpeechRecognitionService.swift
//  home
//
//  Created by 황수비 on 2023/05/26.
//

import Foundation
import UIKit
import Speech
import AVFoundation


class SpeechViewController: UIViewController{
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var responseBtn: UIButton!
    
    @IBOutlet weak var speechBackBtn: UIButton!
    
    
    var audioUrl: URL?
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    var text: String?
    
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "배가 불러서 기분이 너무 좋아요!")
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        responseBtn.setImage(UIImage(named: GlobalMAainCharacter.shared.systemMainImageName), for: .normal)
        
        resultLabel.layer.cornerRadius = 10
        resultLabel.layer.masksToBounds = true
        
        responseLabel.layer.cornerRadius = 10
        responseLabel.layer.masksToBounds = true
        responseLabel.layer.borderWidth = 2
        responseLabel.layer.borderColor = UIColor(red: 0.6, green: 0.807, blue: 0.506, alpha: 1.0).cgColor
        
        
        
        SFSpeechRecognizer.requestAuthorization { (status) in
            switch status {
            case .notDetermined: print("Not determined")
            case .restricted: print("Restricted")
            case .denied: print("Denied")
            case .authorized: print("We can recognize speech now.")
            @unknown default: print("Unknown case")
            }
        }
        transcribeAudio()
    }
    //
    
    
    func transcribeAudio() {
        guard let audioUrl = audioUrl else {
            print("Can't find audio url")
            return
        }
        
        if speechRecognizer!.isAvailable {
            let request = SFSpeechURLRecognitionRequest(url: audioUrl)
            speechRecognizer?.supportsOnDeviceRecognition = true
            speechRecognizer?.recognitionTask(
                with: request,
                resultHandler: { (result, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let result = result {
                        print(result.bestTranscription.formattedString)
                        if result.isFinal {
                            self.text = result.bestTranscription.formattedString
                            self.resultLabel.text = result.bestTranscription.formattedString
                            
                        }
                    }
                })
        }
    }
    
    
    @IBAction func pressResponseBtn(_ sender: UIButton) {
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 0.9
        synthesizer.speak(utterance)
        
        responseLabel.text = utterance.speechString
    }
    
    func gotoHomeView(){
        self.presentingViewController?.dismiss(animated: true)
        guard let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "NaviagationController") as? UINavigationController else { return }
                HomeVC.modalTransitionStyle = .coverVertical
                HomeVC.modalPresentationStyle = .fullScreen
                self.present(HomeVC, animated: true, completion: nil)
    }
    
    @IBAction func pressBackBtn(_ sender: UIButton) {
        self.gotoHomeView()
    }
    
}

