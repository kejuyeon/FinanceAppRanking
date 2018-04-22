//
//  MyImageView.swift
//  FinanceAppRanking
//
//  Created by Juyeon Kim on 2018. 4. 19..
//  Copyright © 2018년 Juyeon Kim. All rights reserved.
//

import UIKit


extension UIImageView
{
    func roundCornersForAspectFit(radius: CGFloat)
    {
        if let image = self.image {
            
            let boundsScale = self.bounds.size.width / self.bounds.size.height
            let imageScale = image.size.width / image.size.height
            
            var drawingRect: CGRect = self.bounds
            
            if boundsScale > imageScale {
                drawingRect.size.width =  drawingRect.size.height * imageScale
                drawingRect.origin.x = (self.bounds.size.width - drawingRect.size.width) / 2
            } else {
                drawingRect.size.height = drawingRect.size.width / imageScale
                drawingRect.origin.y = (self.bounds.size.height - drawingRect.size.height) / 2
            }
            let path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

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
        

        
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data) else {
                        return
                    }
                    self.imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                }.resume()
        }
        
    }

}
