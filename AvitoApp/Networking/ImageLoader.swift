//
//  ImageLoader.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 29.08.2023.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()

    private var cache: NSCache<NSString, UIImage> = NSCache()

    func loadImage(withURL url: URL, completion: @escaping (UIImage?) -> ()) -> URLSessionDataTask? {
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return nil
        } else {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
            task.resume()
            return task
        }
        
    }
}
