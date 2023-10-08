//
//  AudioViewController.swift


import UIKit
import AVFoundation
import AVKit

class AudioViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var audioFileName: URL?
    
    //MARK: -свойства
    
    private lazy var recordButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(recordAction), for: .touchUpInside)
        button.setImage(UIImage(named: "zzz"), for: .normal)
        return button
    }()
  
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        button.setImage(UIImage(named: "stop"), for: .normal)
        return button
    }()
   
    private lazy var soundButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(playRecording), for: .touchUpInside)
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
    
    //MARK: - методы
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        //путь к файлу
        audioFileName = getDocumentDirectory().appendingPathComponent("myAudioRecord.m4a")
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do{
            try audioSession.setCategory(.record, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Ошибка сессии")
        }
        
        setup()
        audioPermission()
        
    }
    
    private func audioPermission() {
        // для микрофона
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                print("Доступ разрешен")
            } else {
                print("Доступ НЕ разрешен")
            }
        }
    }
    
    
    //начать запись
    @objc func recordAction() {
        
        if let audioFileURL = audioFileName {
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            do {
                audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
                audioRecorder?.delegate = self
                audioRecorder?.prepareToRecord()
                audioRecorder?.record()
                recordButton.setImage(UIImage(named: "zzz"), for: .focused)
            } catch {
                print("Ошибка настройки записи \(error.localizedDescription)")
            }
        } else {
            print("Путь к файлу не определен")
        }

    }
    
    //завершить запись
    @objc func stopAction() {
        audioRecorder?.stop()
        audioPlayer?.stop()
        soundButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
    //воспроизведение
    @objc func playRecording() {
        if let audioFile = audioFileName {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
                audioPlayer?.play()
                soundButton.setImage(UIImage(named: "pause"), for: .normal)
            } catch {
                print("Ошибка playing")
            }
        }
    }
    
    // путь к директории
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //при завершении записи
    func finishRecording(_ recorder: AVAudioRecorder, seccessfully flag: Bool) {
        if flag {
            print("Запись завершилась успешно")
        } else {
            print("Запись завершилась с ошибкой")
        }
    }
    
    func setup() {
        view.addSubview(recordButton)
        view.addSubview(stopButton)
        view.addSubview(soundButton)
        
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        soundButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            recordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            recordButton.trailingAnchor.constraint(equalTo: soundButton.leadingAnchor),
            
            soundButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            soundButton.leadingAnchor.constraint(equalTo: recordButton.trailingAnchor, constant: -10),
            soundButton.trailingAnchor.constraint(equalTo: stopButton.leadingAnchor),
            
            stopButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stopButton.leadingAnchor.constraint(equalTo: soundButton.trailingAnchor, constant: -10),
            stopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
            
        ])
    }
    
    
}

