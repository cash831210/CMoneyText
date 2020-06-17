//
//  APICollectionViewController.swift
//  CMoneyText
//
//  Created by 莊鎧旭 on 2020/6/17.
//  Copyright © 2020 Cash. All rights reserved.
//

import UIKit

private let reuseIdentifier = "APICollectionViewCell"

class APICollectionViewController: UICollectionViewController {
    
    var apiTest = [APITest]()
    
    func setupCellSize() {
        
        //item間距
        let itemSpace: CGFloat = 0
        //銀幕寬度放幾個items
        let columnCount: CGFloat = 4
        //離手機銀幕多少距離
        let inset: CGFloat = 0
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount-1) - inset * 2) / columnCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
        flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func getAPITestInfo() {
        let urlStr = "https://jsonplaceholder.typicode.com/photos"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let apiTestData = try? decoder.decode([APITest].self, from: data){
                    self.apiTest = apiTestData
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCellSize()
        getAPITestInfo()
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return apiTest.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! APICollectionViewCell
        
        let selectCell = apiTest[indexPath.item]
        
        if let url = URL(string: selectCell.thumbnailUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
            }.resume()
        }
        
        cell.idLabel.text = String(selectCell.id)
        cell.titleLabel.text = selectCell.title
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "APIDetailViewController") as? APIDetailViewController
        
        detailVC?.selectCell = self.apiTest[indexPath.item]
        
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    
}
