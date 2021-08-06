//
//  BreedImagesViewController.swift
//  DemoApp
//
//  Created by Kalpesh on 25/04/21.
//

import UIKit
import TheDogSDK

class BreedImagesViewController: UIViewController {

    private struct Constants {
        static let title = "Breed Images"
        static let loadingFooterID = "loadingFooter"
        static let breedImageCellID = String(describing: BreedImageCell.self)
        static let collectionViewItemSpacing: CGFloat = 1
        static let collectionViewColumns: Int = 3
        static let loaderHeight: CGFloat = 50
    }

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var noDataLabel: UILabel!

    private let pageLimit = 30
    private var page = 0
    private var images = [BreedImage]()
    private var shouldLoadImages = true

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.collectionViewItemSpacing
        layout.minimumInteritemSpacing = Constants.collectionViewItemSpacing
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        setupView()
        fetchImages()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let itemSize = (collectionView.bounds.width - (Constants.collectionViewItemSpacing * CGFloat(Constants.collectionViewColumns - 1))) / CGFloat(Constants.collectionViewColumns)
        collectionViewLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        collectionViewLayout.invalidateLayout()
    }

    private func setupView() {
        setupSearchBar()
        setupCollectionView()
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    private func setupCollectionView() {
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func resetPagingAndSearchImages() {
        page = 0
        images.removeAll()
        collectionView.reloadData()
        shouldLoadImages = true
        fetchImages()
    }

    private func fetchImages() {
        if !shouldLoadImages { return }

        shouldLoadImages = false
        showLoadingIndicator(true)

        var params = BreedImageParams(page: page, limit: pageLimit)
        params.breed = searchBar.text
        params.size = .thumbnail
        params.order = .ascending
        DogService.searchImages(params: params) { [weak self] (result, error) in
            guard let self = self else { return }
            self.showLoadingIndicator(false)
            self.shouldLoadImages = true

            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
                return
            }

            if let images = result?.data, !images.isEmpty {
                let newIndexPath = self.images.count
                let lastIndexPath = newIndexPath + (images.count - 1)
                var newRows = [IndexPath]()
                for i in newIndexPath...lastIndexPath {
                    newRows.append(IndexPath(row: i, section: 0))
                }
                self.images.append(contentsOf: images)
                self.collectionView.performBatchUpdates {
                    self.collectionView.insertItems(at: newRows)
                }
            }
            self.noDataLabel.isHidden = !self.images.isEmpty

            if let count = result?.count {
                self.shouldLoadImages = self.images.count < count
            }
        }
    }

    private func showLoadingIndicator(_ show: Bool) {
        collectionViewLayout.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: show ? Constants.loaderHeight : 0)
        collectionViewLayout.invalidateLayout()
    }

    @IBAction private func breedsButtonTapped() {
        if let vc = storyboard?.instantiateViewController(identifier: String(describing: BreedsViewController.self)) as? BreedsViewController {
            vc.delegate = self
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true, completion: nil)
        }
    }
}

extension BreedImagesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetPagingAndSearchImages()
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension BreedImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BreedImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.breedImageCellID, for: indexPath) as! BreedImageCell
        cell.setImage(imageUrl: images[indexPath.item].url ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let loadingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.loadingFooterID, for: indexPath)
            return loadingFooter
        }
        return UICollectionReusableView()
    }
}

extension BreedImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO
    }
}

extension BreedImagesViewController: BreedsViewControllerDelegate {
    func didSelectBreed(_ breed: Breed) {
        searchBar.text = breed.name
        resetPagingAndSearchImages()
    }
}

extension BreedImagesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && shouldLoadImages) {
            page+=1
            fetchImages()
        }
    }
}
