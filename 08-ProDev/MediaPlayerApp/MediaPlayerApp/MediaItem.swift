//
//  MediaItem.swift
//  MediaPlayerApp
//
//  Created by Jungman Bae on 7/5/24.
//

import Foundation

struct MediaItem {
    let url: URL
    let title: String
    let isVideo: Bool
}

extension MediaItem {
    static let samples = [
        MediaItem(url: Bundle.main.url(forResource: "Small World", withExtension: "mp3")!, title: "ㅣ MP3 Sample", isVideo: false),
        MediaItem(url: URL(string:"https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!, title: "Short MP3 Sample", isVideo: false),
        MediaItem(url: URL(string:"https://filesamples.com/samples/audio/mp3/sample2.mp3")!, title: "Long MP3 Sample", isVideo: false),
        MediaItem(url: URL(string:"https://filesamples.com/samples/video/mp4/sample_640x360.mp4")!, title: "Medium MP4 Sample", isVideo: true),
        MediaItem(url: URL(string:"https://filesamples.com/samples/video/mp4/sample_960x540.mp4")!, title: "Large MP4 Sample", isVideo: true),
    ]
}
