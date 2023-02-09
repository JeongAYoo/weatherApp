//
//  SideMenuViewController.swift
//  weatherApp
//
//  Created by Jade Yoo on 2023/02/09.
//

import UIKit
import SnapKit
import RealmSwift
import CoreLocation

final class SideMenuViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let localRealm = try! Realm()
    var tasks: Results<UserCity>!
    var mainLocation = MainLocation.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        
        tasks = localRealm.objects(UserCity.self)
        print(tasks)
        
        setupView()
        
    }
    
    func setupView() {
        view.backgroundColor = UIColor(displayP3Red: 131/255, green: 166/255, blue: 247/255, alpha: 1)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 50
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}
// MARK: - UITableViewDataSource
extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return tasks.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.setData("설정")
        } else {
            cell.setData(tasks[indexPath.row].cityName)
        }
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            present(SettingViewController(), animated: true)
        } else {
            mainLocation.value = CLLocation(latitude: tasks[indexPath.row].latitude, longitude: tasks[indexPath.row].longitude)
            dismiss(animated: true)
        }
        
    }
}
