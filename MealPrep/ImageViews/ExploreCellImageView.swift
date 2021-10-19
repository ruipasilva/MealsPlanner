//
//  CellImageView.swift
//  MealPrep
//
//  Created by Rui Silva on 22/09/2021.
//

import UIKit

class ExploreCellImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    var placeholderImage = UIImage(named: "food-placeholder")

    func downloadImages(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
    
}
