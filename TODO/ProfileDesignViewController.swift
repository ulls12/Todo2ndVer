//
//  ProfileDesignViewController.swift
//  TODO
//
//  Created by t2023-m0044 on 1/31/24.
//

import UIKit
import SafariServices

class ProfileDesignViewController: UIViewController {
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var imageTabBar: UITabBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var viewTabBar: UITabBar!
    
    let images = ImageData.iamgeNames
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allDesign()
        
    }
    
    func allDesign() {
        messageButtonDesign()
        followButtonDesign()
        imageTabBarDesign()
        viewTabBarDesign()
        setCollectionView()
        urlLabelDesign()
    }
    
    func urlLabelDesign() {
        urlLabel.textColor = UIColor(red: 0.061, green: 0.274, blue: 0.492, alpha: 1)
      
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(tap)

    }
    
    @objc func labelTapped() {
        let url = NSURL(string: "https://spartacodingclub.kr/")
        let safariView: SFSafariViewController = SFSafariViewController(url: url as! URL)
        self.present(safariView, animated: true, completion: nil)
    }
    
    func followButtonDesign() {
        followButton.layer.backgroundColor = UIColor(red: 0.22, green: 0.596, blue: 0.953, alpha: 1).cgColor
        followButton.layer.cornerRadius = 4
    }
    
    func messageButtonDesign() {
        messageButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        messageButton.layer.cornerRadius = 4
        messageButton.layer.borderWidth = 1.5
        messageButton.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
    }
    
    func imageTabBarDesign() {
        imageTabBar.barTintColor = UIColor.white
        imageTabBar.tintColor = UIColor.black
        imageTabBar.unselectedItemTintColor = UIColor.black
        imageTabBar.backgroundColor = UIColor.white
    }
    
    func viewTabBarDesign() {
        viewTabBar.barTintColor = UIColor.white
        viewTabBar.tintColor = UIColor.black
        viewTabBar.unselectedItemTintColor = UIColor.black
        viewTabBar.backgroundColor = UIColor.white
    }
    
    func setCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        imageCollectionView.collectionViewLayout = flowLayout
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
}

extension ProfileDesignViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "instagramImage", for: indexPath) as! InstagramImageCell
        
        if let image = UIImage(named: images[indexPath.item]) {
            cell.imageView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 4) / 3
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
