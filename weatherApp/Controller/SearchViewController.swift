//
//  SearchViewController.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/11/14.
//

import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: SearchResultViewController())


    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setupSearchBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    // MARK: - Configure
    func setupView() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "검색"
    }
    
    func setConstraints() {
        
    }
    
    func setupSearchBar() {
        navigationItem.searchController = searchController

        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출
    func updateSearchResults(for searchController: UISearchController) {
        // 글자를 치는 순간에 다른 화면 보여주기
        let vc = searchController.searchResultsController as! SearchResultViewController
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}
