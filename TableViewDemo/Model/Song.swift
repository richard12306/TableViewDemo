//
//  Song.swift
//  Swift Template
//
//  Created by 吴文鉴 on 10/14/16.
//  Copyright © 2016 ZQ-iOS-Tech-Group. All rights reserved.
//

import Foundation

//Song 类的定义
class Song {
    var name: String
    var artist: String
    var album: String
    var composer: String
    var length: Int
    var containedList = [Playlist]()
    init(name _name: String = "Unknown", artist _artist: String = "John Doe", album _album: String = "Mystery", composer _composer: String = "Richard Roe", length _length: Int = 0) {
        name = _name
        artist = _artist
        album = _album
        composer = _composer
        length = _length
    }
    
    func addTo(playlist: Playlist) {
        playlist.add(song: self)
    }
    
    func addTo(musicCollection: MusicCollection) {
        musicCollection.addToLibrary(song: self)
    }
    
    func removeFromMusicCollection() {
        for playlist in containedList {
            playlist.remove(song: self)
        }
        containedList.removeAll()
    }
    
//    deinit {
//        print("song \(name) has been released")
//    }
    
}

extension Song : CustomStringConvertible {
    var description: String {
        return "Song name: \(name)\n  Perform by: \(artist)\n  belong to album: \(album)\n  Create by: \(composer)\n  Duration:  \(length)\n"
    }
}

extension Song: Hashable {
    
    var hashValue: Int {
        return description.hashValue
    }
    
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
