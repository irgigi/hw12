//
//  ViewController.swift
//  Multimedia


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var audioPlayer: AVAudioPlayer!
    private var counter = 0
    // данные файлов
    var array = Songs.songsArray()
    
    //MARK: - свойства
    
    private lazy var soundButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(soundAction), for: .touchUpInside)
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        button.setImage(UIImage(named: "stop"), for: .normal)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        button.setImage(UIImage(named: "next"), for: .normal)
        return button
    }()
    
    private lazy var nameSongLabel: UILabel = {
        let label = UILabel()
        label.text = array[counter].title//songs[counter]
        return label
    }()
    
    private lazy var youTubeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextController), for: .touchUpInside)
        button.setImage(UIImage(named: "youtube"), for: .normal)
        return button
    }()
    
    private lazy var audioButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(audioAction), for: .touchUpInside)
        button.setImage(UIImage(named: "record"), for: .normal)
        return button
    }()
    
    
    //MARK: - методы

    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackgroundImage()
        setupAudioPlayer()
        setup()
    }
    
    public func loadBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @objc func nextController() {
        let youController = YouTubeViewController()
        youController.modalTransitionStyle = .coverVertical
        youController.modalPresentationStyle = .pageSheet
        present(youController, animated: true, completion: nil)
    }
    
    @objc func soundAction() {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
            soundButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            audioPlayer.play()
            soundButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @objc func stopAction() {
        audioPlayer.stop()
        soundButton.setImage(UIImage(named: "play"), for: .normal)
        audioPlayer.currentTime = 0.0
    }
    
    @objc func nextAction() {
        soundButton.setImage(UIImage(named: "play"), for: .normal)
        if counter == array.count - 1 {
            counter = 0
        } else {
            counter += 1
        }
        nameSongLabel.text = array[counter].title
        setupAudioPlayer()
    }
    
    @objc func audioAction() {
        
        let audioController = AudioViewController()
        navigationController?.pushViewController(audioController, animated: true)


    }

    
    private func setupAudioPlayer() {
        
        guard let musicUrl = Bundle.main.url(forResource: array[counter].title, withExtension: "mp3") else { return }
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: musicUrl)
            setupAudioSession()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setup() {
        view.addSubview(soundButton)
        view.addSubview(stopButton)
        view.addSubview(nextButton)
        view.addSubview(nameSongLabel)
        view.addSubview(youTubeButton)
        view.addSubview(audioButton)
        
        soundButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nameSongLabel.translatesAutoresizingMaskIntoConstraints = false
        youTubeButton.translatesAutoresizingMaskIntoConstraints = false
        audioButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            audioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            audioButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            
            nameSongLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameSongLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            
            soundButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            soundButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            soundButton.trailingAnchor.constraint(equalTo: stopButton.leadingAnchor, constant: -10),
            
            stopButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -20),
            stopButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stopButton.leadingAnchor.constraint(equalTo: soundButton.trailingAnchor),
            
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.leadingAnchor.constraint(equalTo: stopButton.trailingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            youTubeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            youTubeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            
        ])
        
    }
    
}

