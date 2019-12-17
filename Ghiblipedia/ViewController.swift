//
//  ViewController.swift
//  Ghiblipedia
//
//  Created by Leonardo Diaz on 12/9/19.
//  Copyright © 2019 Leonardo Diaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var filmManager = FilmManager()
    var films = [""]
    var filmDescription = [""]
    var filmDirector = [""]
    var filmRelease = [""]
    var selectedCellRow = 0
    
    
    
    // Set Logo
    func appImage () {
        let logo = UIImage(named: K.imageConstants.logoIdentifier)
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appImage()
        filmManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        filmManager.getFilms()

    }
}

//MARK: - FilmManager Delegate

extension ViewController: FilmManagerDelegate {
    func didGetFilms(filmography: FilmModel) {
        DispatchQueue.main.async {
            self.films = filmography.title
            self.filmDescription = filmography.description
            self.filmRelease = filmography.release_date
            self.filmDirector = filmography.director
            self.tableView.reloadData()
        }
    }
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
}

//MARK: - TableView Delegates

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = films[indexPath.row]
        cell.textLabel?.font = UIFont(name: K.fonts.cellFont, size: 18)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCellRow = indexPath.row
        performSegue(withIdentifier: K.segueIdentifier, sender: self)
    }
}

//MARK: - Navigation

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueIdentifier{
            let detailViewController = segue.destination as? DetailsViewController
            detailViewController?.currentTitle = films[selectedCellRow]
            detailViewController?.filmDescription = filmDescription[selectedCellRow]
            detailViewController?.filmDirector = filmDirector[selectedCellRow]
            detailViewController?.filmRelease = filmRelease[selectedCellRow]
        }
    }
}

