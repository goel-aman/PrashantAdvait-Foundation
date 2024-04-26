//
//  CustomImageView.swift
//  AcharyaPrashantTask
//
//  Created by aman on 26/04/24.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    var task: URLSessionDataTask!
    var imageCache = NSCache<AnyObject, AnyObject>()
    func loadImageFromURL(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            completion(imageFromCache)
            return
        }
        
        if let data = FileManager.default.contents(atPath: url.absoluteString), let image = UIImage(data: data) {
            completion(image)
            imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
            completion(image)
            return
        }
        
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let image = UIImage(data: data)
                self.imageCache.setObject(image!, forKey: url.absoluteString as AnyObject)
                FileManager.default.createFile(atPath: url.absoluteString, contents: data, attributes: nil)
                completion(image)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}
