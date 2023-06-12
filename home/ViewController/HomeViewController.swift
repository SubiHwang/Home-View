//
//  HomeViewController.swift
//  home
//
//  Created by 황수비 on 2023/05/26.
//

import Foundation
import UIKit
import AVFoundation

class HomeViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?

    @IBOutlet weak var mainCharacterImage: UIImageView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var transBtn: UIButton!

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCharacterImage.image = UIImage(named: GlobalMAainCharacter.shared.systemMainImageName)
        
        transBtn.isEnabled = false
        
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                if allowed {
                    print("음성 녹음 허용")
                } else {
                    print("음성 녹음 비허용")
                }
            }
        } catch {
            print("음성 녹음 실패")
        }
        
        
    }
    
    
    @IBAction func pressRecordBtn(_ sender: Any) {
        
        //녹음
        if let recorder = audioRecorder {
            if recorder.isRecording {
                finishRecording(success: true)
            } else {
                startRecording()
            }
        } else {
            startRecording()
        }
    }
    
    
    @IBAction func pressTransBtn(_ sender: UIButton) {
        guard let SpeechViewController = self.storyboard?.instantiateViewController(withIdentifier: "SpeechViewController") as? SpeechViewController else { return }
        SpeechViewController.audioUrl = audioRecorder.url
        SpeechViewController.modalTransitionStyle = .crossDissolve
        SpeechViewController.modalPresentationStyle = .fullScreen
        self.present(SpeechViewController, animated: true, completion: nil)
        
    }
    
}

// MARK: - Recording
extension HomeViewController {
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            print("녹음 시작")
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()

        if success {
            transBtn.isEnabled = true
            print("finishRecording - success")
        } else {
            transBtn.isEnabled = false
            print("finishRecording - fail")
            // recording failed :(
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}






