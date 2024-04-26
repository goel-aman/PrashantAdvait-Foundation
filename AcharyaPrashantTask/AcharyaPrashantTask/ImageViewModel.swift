//
//  ImageViewModel.swift
//  AcharyaPrashantTask
//
//  Created by aman on 25/04/24.
//

import Foundation

protocol ImageService {
    func reloadData()
}

class ImageViewModel {
    let manager = NetworkManager()
    var imageServiceDelegate: ImageService?
    var data: [Query] = [] {
        didSet {
            self.imageServiceDelegate?.reloadData()
        }
    }
    
    func fetchImages(_ query: String) {
        let searchUrl = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100"
        Task {
            do {
                let queryResponse: [Query] = try await manager.getImagesData(from: searchUrl)
                self.data = queryResponse
            } catch {
                print(error)
            }
        }
    }
}
