//
//  Detail.swift
//  FinanceAppRanking
//
//  Created by Juyeon Kim on 2018. 4. 21..
//  Copyright © 2018년 Juyeon Kim. All rights reserved.
//

import Foundation

struct Detail: Codable {
    let resultCount: Int
    let results: [Results]?
}

struct Results: Codable {
    let artistId: Int?
    let artistName: String?
    let artistViewUrl: String?
    let artworkUrl512: String?
    let artworkUrl100: String?
    let averageUserRating: Float?
    let averageUserRatingForCurrentVersion: Float?
    let contentAdvisoryRating: String?
    let currentVersionReleaseDate: String?
    let description: String?
    let screenshotUrls: [String]?
    let sellerName: String?
    let sellerUrl: String?
    let trackCensoredName: String?
    let trackName: String?
    let version: String?
    let genres: [String]?
    let fileSizeBytes: String?
    let supportedDevices: [String]?
}
