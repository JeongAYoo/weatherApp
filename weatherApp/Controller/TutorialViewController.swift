//
//  TutorialViewController.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/11/21.
//

import UIKit
import SnapKit

final class TutorialViewController: UIViewController {
    // MARK: - Properties
    var images = ["mainMockUpCut", "searchMockUpCut"]
    var titleText = ["위치 기반 날씨 정보", "지역 검색과 추가하기"]
    var detailText = ["현재 위치한 곳의 날씨를 자동으로 표시합니다.\n위치 권한 허용이 필요합니다.", "지역을 검색하고, 나만의 리스트에 추가해 언제든 편리하게 날씨 정보를 확인하세요."]
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setConstraints()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(TutorialViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(TutorialViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    // MARK: - AutoLayout
    func setupView() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black

        doneButton.setTitle("Skip", for: .normal)
        
        imgView.image = UIImage(named: "mainMockUpCut")
        
        titleLabel.text = titleText[0]
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        
        detailLabel.text = detailText[0]
        detailLabel.sizeToFit()
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 0
    }
    
    func setConstraints() {
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        imgView.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.bottom.equalTo(pageControl.snp.top).offset(-20)
            make.height.equalTo(350)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.top.equalTo(doneButton.snp.bottom).offset(40)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            pageControl.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
//    }
    // MARK: - IBAction
    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        let vc = AuthCheckViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if (pageControl.currentPage<pageControl.numberOfPages-1) {
                    pageControl.currentPage = pageControl.currentPage + 1
                }
                print("Swiped Left")
            case UISwipeGestureRecognizer.Direction.right:
                if (pageControl.currentPage>0) {
                    pageControl.currentPage = pageControl.currentPage - 1
                }
                print("Swiped Right")
            default:
                break
            }
            
            imgView.image = UIImage(named: images[pageControl.currentPage])
            titleLabel.text = titleText[pageControl.currentPage]
            detailLabel.text = detailText[pageControl.currentPage]
            
            if pageControl.currentPage == 1 {
                doneButton.setTitle("완료", for: .normal)
            } else {
                doneButton.setTitle("Skip", for: .normal)
            }
        }
    }
}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct TutorialVCPreview: PreviewProvider {
//    
//    static var previews: some View {
//        // view controller using programmatic UI
//        TutorialViewController().toPreview()
//    }
//}
//#endif
