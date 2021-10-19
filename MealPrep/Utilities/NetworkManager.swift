//
//  NetworkManager.swift
//  MealPrep
//
//  Created by Rui Silva on 15/09/2021.
//

// \(label.replacingOccurrences(of: " ", with: "+"))

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    var cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getRecipes(for label: String, completed: @escaping(Result<Results, ErrorMessage>) -> Void) {
        
        let urlString = "https://api.edamam.com/api/recipes/v2?type=public&q=\(label.replacingOccurrences(of: " ", with: "+"))&app_id=460c4331&app_key=4b9f55bc266b24dd5053b4cfbebfc6a1"
        
        guard let url = URL(string: urlString) else { return }
        
        let  task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Results.self, from: data)
                completed(.success(results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getRecipeInfo(for uri: String, completed: @escaping(Result<RecipeInfoResult, ErrorMessage>) -> Void) {
        
        let urlString = "https://api.edamam.com/api/recipes/v2/\(uri)?type=public&app_id=460c4331&app_key=4b9f55bc266b24dd5053b4cfbebfc6a1"
        
        guard let url = URL(string: urlString) else { return }
        
        let  task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(RecipeInfoResult.self, from: data)
                completed(.success(results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
