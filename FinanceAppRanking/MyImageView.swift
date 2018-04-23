//
//  MyImageView.swift
//  FinanceAppRanking
//
//  Created by Juyeon Kim on 2018. 4. 19..
//  Copyright © 2018년 Juyeon Kim. All rights reserved.
//

import UIKit

class MyImageView: UIImageView {

    let imageCache = NSCache<NSString, AnyObject>()
    var imageURLString: String?
    
    func imageLayerCornerAndBorder(radius: CGFloat, borderWith: CGFloat, color: CGColor) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWith
        self.layer.borderColor = color
        self.clipsToBounds = true
    }
    
    func downloadImageFrom(_ urlString: String, _ imageMode: UIViewContentMode = .scaleAspectFit ) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url, imageMode)
    }
    
    func downloadImageFrom(_ url: URL, _ imageMode: UIViewContentMode = .scaleAspectFit) {
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data) else {
                        return
                    }
                    self.imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                }
                }.resume()
        }
    }
}
