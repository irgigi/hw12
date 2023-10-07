//
//  Songs.swift
//  Multimedia


import Foundation

struct Songs {
    let title: String
    let videoURL: String?
    
    init(title: String, videoURL: String?) {
        self.title = title
        self.videoURL = videoURL
    }
}

extension Songs {
    
    static func songsArray() -> [Songs] {
        [
            Songs(title: "Элтон Джон - Your song", videoURL: "https://youtu.be/GlPlfCy1urI"),
            Songs(title: "Spice Girls - Too Much", videoURL: "https://youtu.be/_4VoZ6afztc"),
            Songs(title: "Scorpions - Send Me An Angel", videoURL: "https://youtu.be/1UUYjd2rjsE"),
            Songs(title: "Oasis - Wonderwall", videoURL:
                    "https://youtu.be/6hzrDeceEKc"),
            Songs(title: "Mylene Farmer - L'amour N'est Rien", videoURL: "https://youtu.be/w2wrHUQhdfI"),
        ]
    }
    
}


