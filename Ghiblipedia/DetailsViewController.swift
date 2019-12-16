//
//  DetailsViewController.swift
//  Ghiblipedia
//
//  Created by Leonardo Diaz on 12/10/19.
//  Copyright © 2019 Leonardo Diaz. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var currentTitle: String?
    var filmDescription: String?
    var filmRelease: String?
    var filmDirector: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = currentTitle ?? "Title not found"
        descriptionLabel.text = filmDescription ?? "Description not found"
        releaseLabel.text = filmRelease ?? "Release Date not found"
        directorLabel.text = "Directed by: \(filmDirector ?? "Director not found")"
    }
    
}
