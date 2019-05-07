//
//  MemeTableViewController.swift
//  pickimage
//
//  Created by Sayed  on 5/2/19.
//  Copyright © 2019 Sayed . All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
         let empty = memes.count
        if empty == 0 {
            let detailController = self.storyboard!.instantiateViewController(withIdentifier:
                "ViewController") as! ViewController
            self.present(detailController, animated: true, completion: nil)
        }*/
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell

        let meme = self.memes [(indexPath as NSIndexPath).row]
        cell.MemeImageView.image = meme.memedImage
        cell.MemeImageView.contentMode = .scaleAspectFit
        cell.label.text = "\(meme.topText) ... \(meme.bottomText)"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailMeme") as! DetailViewController
        detailController.memes = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
