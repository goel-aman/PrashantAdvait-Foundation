//
//  ImageModel.swift
//  AcharyaPrashantTask
//
//  Created by aman on 23/04/24.
//

import Foundation

struct Query: Codable {
    let id: String
    let title: String
    let thumbnail: Thumbnail
    let mediaType: Int
    let coverageURL: String
    let publishedAt: String
    let publishedBy: String
    let backupDetails: BackupDetails?
}

struct BackupDetails: Codable {
    let pdfLink: String
    let screenshotURL: String
}

struct Thumbnail: Codable {
    let id: String
    let version: Int
    let domain: String
    let basePath: String
    let key: String
    let qualities: [Int]
    let aspectRatio: Int
}
