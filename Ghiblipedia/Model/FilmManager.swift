//
//  FilmManager.swift
//  Ghiblipedia
//
//  Created by Leonardo Diaz on 12/9/19.
//  Copyright © 2019 Leonardo Diaz. All rights reserved.
//

import Foundation

protocol FilmManagerDelegate {
    func didGetFilms(filmography: FilmModel)
    func didFailWithError(_ error: Error)
}

struct FilmManager {
    var delegate: FilmManagerDelegate?
    
    let rootUrl = "https://ghibliapi.herokuapp.com/films"
    
    func getFilms(){
        performRequest(baseURL: rootUrl)
    }
    
    func performRequest(baseURL: String){
        if let url = URL(string: baseURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler:{ (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let filmData = self.parseJSON(safeData){
                        self.delegate?.didGetFilms(filmography: filmData)
                    }
                }
            })
            task.resume()
        }
    }
    
    
    func parseJSON(_ data: Data) -> FilmModel? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([FilmData].self, from: data)
            
            var filmTitles: [String]
            filmTitles = []
            var filmDescriptions: [String]
            filmDescriptions = []
            var filmDirector: [String]
            filmDirector = []
            var filmRelease: [String]
            filmRelease = []
            
            for i in 0..<decodedData.count{filmTitles.append(decodedData[i].title)}
            for i in 0..<decodedData.count{filmDescriptions.append(decodedData[i].description)}
            for i in 0..<decodedData.count{filmDirector.append(decodedData[i].director)}
            for i in 0..<decodedData.count{filmRelease.append(decodedData[i].release_date)}
            
            return FilmModel(title: filmTitles, description: filmDescriptions, director: filmDirector, release_date: filmRelease)
            
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    
}
