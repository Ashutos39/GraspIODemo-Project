//
//  ViewController.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher
import ViewAnimator

class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private var allImagesDetails:AllImageDetails? = nil
    private let animations = [AnimationType.from(direction: .left, offset: 50.0)]
    private var dataArray = [[String:AnyObject]]()
    private var dataForDBinsert = [[String:AnyObject]]()
    private var limit = 12
    private var index = 0

    private var recordArray = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerCollectionCell()
        while index < limit {
            recordArray.append(index)
            index = index + 1
        }
        loadData()
    }

    private func registerCollectionCell() {
        let listColllectionViewCell = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        collectionView.register(listColllectionViewCell, forCellWithReuseIdentifier: "ListCollectionViewCell")
    }

    private func setUpUI() {
        let itemSize = UIScreen.main.bounds.width/2 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        layout.itemSize = CGSize(width : itemSize, height: itemSize )
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView.collectionViewLayout = layout
    }

    private func loadData() {
        if Connectivity.isConnectedToInternet() == true {
            loadListFromAPI()
        } else {
            getAllImageDetails()
            guard let imageList = allImagesDetails?.imageList?.array, imageList.count != 0 else {
                AlertView.showAlertView("Warning!!!!", body: "No data found in database", cancelButtonTitle: nil, okButtonTitle: "OK", cancelPressed: {}, okPressed: {})
                return
            }
            self.collectionView.reloadData()
        }
        collectionView?.performBatchUpdates({
            UIView.animate(views: self.collectionView!.orderedVisibleCells,
                           animations: animations, completion: {
            })
        }, completion: nil)
    }

    private func loadListFromAPI() {
        SVProgressHUD.show(withStatus: "Please Wait...")
        WebService.sharedService.imageDetails { (data, error) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                if error != nil {
                    AlertView.showAlertView("Warning!!!!", body: "Kindly Check your internet connection, and try again...", cancelButtonTitle: nil, okButtonTitle: "OK", cancelPressed: {}, okPressed: {})
                    return
                }
                self.getAllImageDetails()
                self.collectionView.reloadData()
            }
        }
    }

    private func getAllImageDetails() {
        allImagesDetails = AllImageDetails.fetchImageList()
    }
}

//MARK : CollectionViewDelegate
extension ListViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if allImagesDetails?.imageList?.array != nil{
            return recordArray.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let individualImageDetails = allImagesDetails?.imageList?[indexPath.row] as? ImageDetails, let imageUrl = individualImageDetails.imageUrl {
            cell.setImage(url: imageUrl)
        }
        cell.contentView.backgroundColor = .white
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let totalcount = 100
        if indexPath.row == recordArray.count - 1{
            // we are at last cell load more content
            if recordArray.count < totalcount{
                // we need to bring more records as there are some pending records available
                var index = recordArray.count
                if index != 96{
                    limit = index + 12
                } else {
                    limit = index + 4
                }
                while index < limit {
                    recordArray.append(index)
                    index = index + 1
                }
                self.perform(#selector(loadCollectionView), with: nil, afterDelay: 1.0)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailsController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController,
            let individualImageDetails = allImagesDetails?.imageList?[indexPath.row] as? ImageDetails {
            detailsController.imageDetails = individualImageDetails
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }

    @objc func loadCollectionView() {
        self.collectionView.reloadData()
    }
}
