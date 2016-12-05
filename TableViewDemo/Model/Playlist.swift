//
//  Playlist.swift
//  Swift Template
//
//  Created by 吴文鉴 on 10/14/16.
//  Copyright © 2016 ZQ-iOS-Tech-Group. All rights reserved.
//

import Foundation

// Playlist 类的定义
class Playlist {
    var name: String
    var songList = [Song]()
    let isLibrary: Bool
    unowned var superCollection: MusicCollection
    
    init(name _name: String, songList: [Song]? = nil, superCollection _superCollection: MusicCollection, isLibrary _isLibrary: Bool = false) {
        name = _name
        superCollection = _superCollection
        isLibrary = _isLibrary
        songList?.forEach { add(song: $0, mute: true) }
        if isLibrary {return}
        superCollection.add(playlist: self)
    }
    
    @discardableResult
    func add(song: Song, mute: Bool = false) -> Bool {
        if songList.contains(song) {
            if !mute {
                print("song \(song.name) already exist in playlist \(name)")
            }
            return false
        }
        songList.append(song)
        if !isLibrary {
            song.containedList.append(self)
            superCollection.addToLibrary(song: song, mute: true)
        }
        return true
    }
    
    func add(songs: [Song], mute: Bool = false) {
        songs.forEach { _ = self.add(song: $0, mute: mute) }
    }
    
    func remove(song: Song) {
        guard songList.contains(song) else {
            let errorInfo = isLibrary ? "music collection \(superCollection.name)" : "playlist \(name)"
            print("song \(song.name) not found in \(errorInfo)")
            return
        }
        for index in 0..<songList.count {
            if songList[index] == song {
                songList.remove(at: index)
                break
            }
        }
        if isLibrary {
            song.removeFromMusicCollection()
        }
    }
    
    func remove(songs: [Song]) {
        songs.forEach { self.remove(song: $0) }
    }
    
}

extension Playlist: CustomStringConvertible {
    var description: String {
        let libraryInfo = isLibrary ? "is the library of music collection \(superCollection.name)\n  " : ""
        return "Playlist name: \(name)\n  \(libraryInfo)contain \(songList.count) Song(s)\n  belong to music collection: \(superCollection.name)\n"
    }
}

extension Playlist: Hashable {

    var hashValue: Int {
        return description.hashValue
    }
    
    static func ==(lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
