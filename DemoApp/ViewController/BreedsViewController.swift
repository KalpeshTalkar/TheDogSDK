//
//  BreedsViewController.swift
//  DemoApp
//
//  Created by Kalpesh on 21/04/21.
//

import UIKit
import TheDogSDK

protocol BreedsViewControllerDelegate: class {
    func didSelectBreed(_ breed: Breed)
}

class BreedsViewController: UIViewController {

    private struct Constants {
        static let title = "Breeds"
        static let cellID = String(describing: UITableViewCell.self)
        static let pageLimit = 30
        static let loaderHeight: CGFloat = 44
    }

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noDataLabel: UILabel!

    private var shouldLoadBreeds = true
    private var page = 0
    private var breeds = [Breed]()
    weak var delegate: BreedsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        setupView()
        fetchBreeds()
    }

    private func setupView() {
        setupSearchBar()
        setupTableView()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    private func resetPagingAndSearchBreeds() {
        page = 0
        breeds.removeAll()
        tableView.reloadData()
        shouldLoadBreeds = true
        fetchBreeds()
    }

    private func searchBreeds(breedName: String) {
        DogService.searchBreeds(breedName: breedName, page: page, limit: Constants.pageLimit) { [weak self] (result, error) in
            self?.handleBreedsResponse(result: result, error: error)
        }
    }

    private func fetchAllBreeds() {
        DogService.getAllBreeds(page: page, limit: Constants.pageLimit) { [weak self] (result, error) in
            self?.handleBreedsResponse(result: result, error: error)
        }
    }

    private func fetchBreeds() {
        if !shouldLoadBreeds { return }

        shouldLoadBreeds = false
        showLoadingIndicator(true)

        if let breedName = searchBar.text, !breedName.isEmpty {
            searchBreeds(breedName: breedName)
        } else {
            fetchAllBreeds()
        }
    }

    private func handleBreedsResponse(result: PaginatedData<[Breed]>?, error: DogServiceError?) {
        showLoadingIndicator(false)

        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }

        if let breeds = result?.data, !breeds.isEmpty {
            let newIndexPath = self.breeds.count
            let lastIndexPath = newIndexPath + (breeds.count - 1)
            var newRows = [IndexPath]()
            for i in newIndexPath...lastIndexPath {
                newRows.append(IndexPath(row: i, section: 0))
            }
            self.breeds.append(contentsOf: breeds)
            tableView.beginUpdates()
            tableView.insertRows(at: newRows, with: .automatic)
            tableView.endUpdates()
        }
        noDataLabel.isHidden = !self.breeds.isEmpty

        if let count = result?.count {
            shouldLoadBreeds = breeds.count < count
        }
    }

    private func showLoadingIndicator(_ show: Bool) {
        if show {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: Constants.loaderHeight)

            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        } else {
            tableView.tableFooterView = UIView()
        }
    }

    @IBAction private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension BreedsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetPagingAndSearchBreeds()
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension BreedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath)
        cell.textLabel?.text = breeds[indexPath.row].name
        cell.detailTextLabel?.text = breeds[indexPath.row].description
        return cell
    }
}

extension BreedsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didSelectBreed(self.breeds[indexPath.row])
        }
    }
}

extension BreedsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && shouldLoadBreeds) {
            page+=1
            fetchBreeds()
        }
    }
}
