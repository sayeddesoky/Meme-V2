//
//  DetailViewController.swift
//  pickimage
//
//  Created by Sayed  on 5/2/19.
//  Copyright © 2019 Sayed . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var memes : Meme!
    @IBOutlet weak var Detailimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editMeme))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Detailimage.image = memes.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func editMeme(){
        let memeViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        memeViewController.editmeme = memes
        self.navigationController?.pushViewController(memeViewController, animated: true)
    }
    
    
    
}
