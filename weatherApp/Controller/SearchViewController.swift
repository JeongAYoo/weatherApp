//
//  SearchViewController.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/11/14.
//

import UIKit
import MapKit

final class SearchViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
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
}
