//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/27/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {

    var avatarType = AvatarType.dark
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        avatarType = AvatarType(rawValue: segmentControl.selectedSegmentIndex)!
        
        collectionView.reloadData()
    } 
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    } 
}

// MARK: - UICollectionViewDelegate
extension AvatarPickerVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns: CGFloat = 3
        
        if UIScreen.main.bounds.width > 320 {
            numberOfColumns = 4
        }
        
        let spaceBetweenCell: CGFloat = 10
        let padding: CGFloat = 40
        let cellDimension = (collectionView.bounds.width - padding - (numberOfColumns - 1) * spaceBetweenCell) / numberOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
}

// MARK: - UICollectionViewDelegate
extension AvatarPickerVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension AvatarPickerVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(forIndex: indexPath.item, withType: avatarType)
            
            return cell
        }
        
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
}
