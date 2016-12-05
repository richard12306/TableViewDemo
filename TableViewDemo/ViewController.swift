//
//  ViewController.swift
//  TableViewDemo
//
//  Created by richard on 11/19/16.
//  Copyright © richard. All rights reserved.
//

import UIKit

class CollectionViewController: UITableViewController {

    var ThePlaylist: Playlist?
    var UItableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.delegate = self
        tableView!.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let identify:String = "playlistCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as UITableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = ThePlaylist?.songList[indexPath.row].name
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func UItableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var TheSong: Song
        TheSong = ThePlaylist!.songList[indexPath.row]
        let alertViewController = UIAlertController(title: "demo", message: "name: \(TheSong.name) artise: \(TheSong.artist) album: \(TheSong.album)  length: \(TheSong.length) ", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
}

