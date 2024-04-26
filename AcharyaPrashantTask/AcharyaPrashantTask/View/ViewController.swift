//
//  ViewController.swift
//  AcharyaPrashantTask
//
//  Created by aman on 23/04/24.
//

import UIKit

class ViewController: UIViewController, ImageService {
    let imageViewModel = ImageViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        imageViewModel.imageServiceDelegate = self
        imageViewModel.fetchImages("")
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        var url = imageViewModel.data[indexPath.row].thumbnail.domain
        url = url + "/"
        url = url + imageViewModel.data[indexPath.row].thumbnail.basePath
        url = url + "/0/"
        url = url + imageViewModel.data[indexPath.row].thumbnail.key
        cell.imageView.image = nil
        cell.imageView.loadImageFromURL(url: URL(string: url)!) { image in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        return cell
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 120)
    }
}

