//
//  SearchResultViewController.swift
//  weatherApp
//
//  Created by Jade Yoo on 2023/01/25.
//

import UIKit
import MapKit
import SnapKit

final class SearchResultViewController: UIViewController {
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    private var searchCompleter = MKLocalSearchCompleter() /// 검색을 도와주는 변수
    private var searchResults = [MKLocalSearchCompletion]() /// 검색 결과를 담는 변수
    
    
    var searchTerm: String? {
        didSet {
            searchCompleter.queryFragment = searchTerm ?? ""
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearchCompleter()
    }
    
    // MARK: - Helpers
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "SearchResultTableViewCell")
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address /// resultTypes은 검색 유형인데 address는 주소를 의미
    }
    
    
}

// MARK: - MKLocalSearchCompleterDelegate
extension SearchResultViewController: MKLocalSearchCompleterDelegate {
    // 자동완성 완료 시에 결과를 받는 함수
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // completer.results를 통해 검색한 결과를 searchResults에 담아줌
        searchResults = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // 에러 확인
        print(error.localizedDescription)
    }
}

// MARK: - UITableViewDataSource
extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        cell.regionLabel.text = searchResults[indexPath.row].title
        
        return cell
    }
    

}

// MARK: - UITableViewDelegate
extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchReqeust = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchReqeust)
        search.start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            let searchLatitude = placeMark.coordinate.latitude
            let searchLongtitude = placeMark.coordinate.longitude
            
            //print(placeMark.title)
            
            let vc = MainViewController()
            vc.testLocation = CLLocation(latitude: searchLatitude, longitude: searchLongtitude)
            //self.presentingViewController?.navigationController?.popViewController(animated: true)
            //self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            //vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
