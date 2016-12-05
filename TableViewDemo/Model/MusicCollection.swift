//
//  MusicCollection.swift
//  Swift Template
//
//  Created by 吴文鉴 on 10/14/16.
//  Copyright © 2016 ZQ-iOS-Tech-Group. All rights reserved.
//

import Foundation

//MusicCollection 类的定义
class MusicCollection {
    var name: String
    lazy var library: Playlist = {
        return Playlist(name: "\(self.name)'s library", superCollection: self, isLibrary: true)
    }()
    
    var subList: [Playlist]
    var allSong: [Song] {
        return library.songList
    }
    
    init(name _name: String) {
        name = _name
        subList = []
    }
    
    func addToLibrary(song: Song, mute: Bool = false) {
        library.add(song: song, mute: mute)
    }
    
    func removeFromLibrary(song: Song) {
        library.remove(song: song)
    }
    
    func add(playlist: Playlist) {
        if subList.contains(playlist) {
            print("Playlist \(playlist.name) was already existed in collection \(name)")
            return
        }
        subList.append(playlist)
        playlist.songList.forEach { addToLibrary(song: $0, mute: true) }
    }
    
    func remove(playlist: Playlist, deleteSong: Bool) {
        guard subList.contains(playlist) else {
            print("Playlist \(playlist.name) not found in collection \(name)")
            return
        }
        for index in 0..<subList.count {
            if subList[index] == playlist {
                playlist.songList.forEach { removeFromLibrary(song: $0) }
                subList.remove(at: index)
                return
            }
        }
    }
    
}

extension MusicCollection: CustomStringConvertible {
    var description: String {
        return "Music collection: \(name)\n  contain \(subList.count) playlist(s)\n  has \(allSong.count) in total\n"
    }
}

extension MusicCollection: Hashable {
    var hashValue: Int {
        return description.hashValue
    }
    
    static func ==(lhs: MusicCollection, rhs: MusicCollection) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
