//
//  Utils.swift
//  FinanceAppRanking
//
//  Created by Juyeon Kim on 2018. 4. 21..
//  Copyright © 2018년 Juyeon Kim. All rights reserved.
//

import UIKit

enum iTunesRSS {
    case topfreeRank
    case topfreeRankDetail(String)
    
    var urlStr: String {
        switch self {
        case .topfreeRank:
            let urlStr = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"
            return urlStr
        case .topfreeRankDetail(let appId):
            let urlStr = "https://itunes.apple.com/lookup?id=\(appId)&country=kr"
            return urlStr
        }
    }
}

extension UIButton {
    func buttonCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}


class Utils: NSObject {
    private override init() { }
    static let shared = Utils()
    
    func loadEntryData(_ urlStr: String, _ completHandler: @escaping ([Entry]) -> Void) {
        
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let appList = try decoder.decode(MyEntry.self, from: data)
                DispatchQueue.main.async(execute: {
                    guard let entry = appList.feed?.entry else { return }
                    completHandler(entry)
                    
                })
                
            } catch let error as NSError {
                print(error)
            }
            }.resume()
    }
    
    
    func loadDetailData(_ urlStr: String, _ completeHandler: @escaping (Detail) ->Void) {
        
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(Detail.self, from: data)
                DispatchQueue.main.async(execute: {
                    completeHandler(decodeData)
                })
                
            } catch let error as NSError {
                print(error)
            }
            }.resume()
    }

}
