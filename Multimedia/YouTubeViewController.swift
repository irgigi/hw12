//
//  YouTubeViewController.swift
//  Multimedia


import UIKit
import AVFoundation
import AVKit

class YouTubeViewController: UIViewController {
    
    // данные файлов
    var array = Songs.songsArray()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        setup()
       
    }
    
    private func createVideoPlayer(_ row: Int) {

        guard let videoUrl = URL(string: array[row].videoURL!) else { return }
        print(videoUrl)
        let player = AVPlayer(url: videoUrl)
        
        let controller = AVPlayerViewController()
        controller.player = player
        //controller.showsTimecodes = true
        if let playerLayer = controller.view.layer as? AVPlayerLayer {
            playerLayer.videoGravity = .resizeAspectFill
        }
        present(controller, animated: true) {
            player.play()
        }
    }
    
    func setup() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
}

extension YouTubeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.contentView.frame.size.width = tableView.frame.width
        cell.textLabel?.text = array[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        createVideoPlayer(selectedRow)
        print(selectedRow)
    }
    
    
}
