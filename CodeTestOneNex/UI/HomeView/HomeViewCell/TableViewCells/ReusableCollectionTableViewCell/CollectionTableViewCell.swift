//
//  CollectionTableViewCell.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import UIKit
import Combine

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seeL: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectonViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: RectanglePageControl!
    
    private var cancellables = Set<AnyCancellable>()
    
    
    var viewModel: CollectionCellViewModel!
    var categoryList : [CategoryVO] = []
    var articleList : [ArticleVO] = []


    func setPromotion (data: [CategoryVO]) {
        categoryList = data
        viewModel.cellType = HomeViewControllerSectionType.Promotion
        viewModel.cellCount = categoryList.count
        let itemHeight : CGFloat = 260
        collectonViewHeight.constant = itemHeight
        titleViewHeightConstraint.constant = 60
        pageControl.isHidden = true
        collectionView.reloadData()
    }
    
    func setNewLetter (data: [ArticleVO]) {
        articleList = data

        titleLbl.text = "New Letters"
        viewModel.cellType = HomeViewControllerSectionType.NewLetter
        viewModel.cellCount = articleList.count
        let itemHeight : CGFloat =  320
        collectonViewHeight.constant = itemHeight + 20
        pageControl.isHidden = true
        collectionView.reloadData()
    }
    
    
    func setSlider (data: [CategoryVO]) {
        categoryList = data
        titleViewHeightConstraint.constant = 0
        viewModel.cellType = HomeViewControllerSectionType.Slider
        viewModel.cellCount = categoryList.count
        pageControl.numberOfPages = categoryList.count
        let itemHeight : CGFloat = 200
        pageControl.isHidden = false
        collectonViewHeight.constant = itemHeight
        collectionView.reloadData()
    }
    
    func setAnnouncement (data : [CategoryVO]) {
        categoryList = data
        titleLbl.text = "Announcement"
        viewModel.cellType = HomeViewControllerSectionType.Announcement
        let itemHeight : CGFloat =  190
        collectonViewHeight.constant = itemHeight + 20
        
        titleViewHeightConstraint.constant = 60
        pageControl.isHidden = true
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        viewModel = CollectionCellViewModel(cellType: .Slider)
        

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: PromotinCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: PromotinCVCell.identifier)
        collectionView.register(UINib(nibName: SliderCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SliderCollectionViewCell.identifier)
        
        
        pageControl.addTarget(self, action: #selector(self.pageControlSelectionAction(_:)), for: .touchUpInside)
        
    }
    
    @IBAction func pageControlSelectionAction(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        var frame: CGRect = self.collectionView.frame
        frame.origin.x = frame.size.width * CGFloat(page ?? 0)
        frame.origin.y = 0
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}



extension CollectionTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.cellType{
        case .Promotion :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotinCVCell.identifier, for: indexPath) as? PromotinCVCell else { return UICollectionViewCell() }
            cell.setuiForPromotion(data: categoryList[indexPath.row])
            cell.bottomViewHeightConstraint.constant = 60
            cell.bottomview.isHidden = false
            return cell
        case .NewLetter :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotinCVCell.identifier, for: indexPath) as? PromotinCVCell else { return UICollectionViewCell() }
            cell.bottomViewHeightConstraint.constant = 70
            cell.bottomview.isHidden = false
            cell.setuiForNewLetters(data: articleList[indexPath.row])
            return cell
        case .Slider:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.identifier, for: indexPath) as? SliderCollectionViewCell else { return UICollectionViewCell()}
            return cell
            
        case .Announcement:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotinCVCell.identifier, for: indexPath) as? PromotinCVCell else { return UICollectionViewCell() }
            cell.dateLbl.text = customDateString(dateString: categoryList[indexPath.row].updatedAt)
            cell.titleLbl.text = categoryList[indexPath.row].name
            if categoryList.count >= 2 {
                if indexPath.row == 1 {
                    cell.seperatorView.isHidden = true
                }
                else{
                    cell.seperatorView.isHidden = false
                }
            }
            
            cell.bottomview.isHidden = false
            cell.img.isHidden = true
            return cell

        }

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.cellType{
        case .Promotion :
            return CGSize(width: (UIScreen.main.bounds.width ) / 1.5, height: 200)
        case .NewLetter :
            return CGSize(width: (UIScreen.main.bounds.width - 10 ) / 3, height: 260)
        case .Slider:
            return CGSize(width: UIScreen.main.bounds.width  , height: 200)
      
        case .Announcement:
            return CGSize(width: UIScreen.main.bounds.width  , height: 70)
        }
        
         
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           // Customize section insets for each section
        if viewModel?.cellType == .Slider {
               return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
           } else {
               return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
           }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}



