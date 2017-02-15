//
//  WelcomeViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Octavio Cedeno on 2/15/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let proofOfConceptGif = UIImage.gif(name: "hotlineBling")
        gifImageView.image = proofOfConceptGif
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
