//
//  PersistanceManager.swift
//  MealPrep
//
//  Created by Rui Silva on 23/09/2021.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistanceManager {
    
    static let defaults = UserDefaults.standard
    
    enum Keys {
        static let bookmarked = "Bookmarked"
        
    }
    
    static func updateWith(bookmarked: RecipeInfo, actionType: PersistenceActionType, completed: @escaping (ErrorMessage?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let results):
                var retrievedBookmarked = results
                switch actionType {
                    
                case .add:
                    guard !retrievedBookmarked.contains(bookmarked) else {
                        completed(.alreadyBookmarked)
                        return
                    }
                    retrievedBookmarked.append(bookmarked)
                    
                case .remove:
                    retrievedBookmarked.removeAll { $0.label == bookmarked.label }
                }
                completed(save(bookmarks: retrievedBookmarked))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[RecipeInfo], ErrorMessage>) -> Void) {
        guard let bookmarkedData = defaults.object(forKey: Keys.bookmarked) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let bookmarks = try decoder.decode([RecipeInfo].self, from: bookmarkedData)
            completed(.success(bookmarks))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(bookmarks: [RecipeInfo]) -> ErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedBookmarks = try encoder.encode(bookmarks)
            defaults.set(encodedBookmarks, forKey: Keys.bookmarked)
            return nil
        } catch {
            return .unableToFavorite
            
        }
    }
}
