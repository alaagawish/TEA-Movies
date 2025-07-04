//
//  LocalLayer.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import Foundation
import CoreData
import UIKit

class LocalLayer: LocalProtocol {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext: NSManagedObjectContext
    var entity: NSEntityDescription
    init() {
        
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
    }
    
    func add(movies: [MoviesResponseResults]) {
        for i in movies {
            let movieEntity = NSManagedObject(entity: entity, insertInto: managedContext)
            
            movieEntity.setValue(i.releaseDate, forKey: "date")
            movieEntity.setValue(i.title, forKey: "name")
            movieEntity.setValue(i.posterPath, forKey: "imageURL")
            movieEntity.setValue(i.isFave, forKey: "isFave")
            movieEntity.setValue(i.voteAverage, forKey: "rating")
            
            do {
                try managedContext.save()
                print("Movie added to Local source")
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    func changeFaveOfMovie(movie: MoviesResponseResults, isFave: Bool) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "name == %@", movie.title ?? "")
        
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if let movieFound = results?.first {
                movieFound.setValue(isFave, forKey: "isFave")
                
                try managedContext.save()
                print("Updated movie")
                print("movie updated \(movieFound)")
            } else {
                print("No movie found ")
            }
        } catch {
            print("Failed to update: \(error)")
            
        }
        
    }
    
    func getMovies() -> [MoviesResponseResults] {
        var moviesResult: [MoviesResponseResults] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        do {
            let movies = try managedContext.fetch(fetchRequest)
            for i in movies {
                let m = MoviesResponseResults(adult: false, genreIds: [], id: i.value(forKey: "id") as? Int, originalLanguage: "", originalTitle: i.value(forKey: "name") as? String, overview: "", popularity: 0.0, posterPath: i.value(forKey: "imageURL") as? String, releaseDate: i.value(forKey: "date") as? String, title: i.value(forKey: "name") as? String, video: false, voteAverage: i.value(forKey: "rating") as? Int, voteCount: 0, isFave: i.value(forKey: "isFave") as? Bool)
                
                
                moviesResult.append(m)
            }
            print("Getting all movies done...\n")
        } catch let error as NSError{
            print("\nerror in fetching all movies: \(error)\n")
        }
        
        return moviesResult
    }
    
    func clearAllMovies() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Movie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            print("All movies deleted")
        } catch {
            print("Error deleting saved movies: \(error)")
        }
    }
    
}
