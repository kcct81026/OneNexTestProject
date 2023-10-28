//
//  HomeViewController.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 27/10/2023.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    
    
    var viewModel: HomeViewModel!
    private var cancellables = Set<AnyCancellable>()


    

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()

        
        viewModel.fetchArticleList()
        viewModel.fetchArticleCategory()
        
        bindViewState()
        setupUiViews()
        setupTableView()
        setupCollectionView()
        
    }
    
    // MARK: setupUiViews
    private func setupUiViews(){
        searchView.layer.cornerRadius = 20
        searchView.layer.masksToBounds = true
        arrowView.roundCorners([.topLeft, .topRight], radius: 10)
        addCardShadow(to: infoView)
        arrowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleScroll)))

    }
    
    // MARK: BINDVIEWMODELSTATE
    private func bindViewState(){
        viewModel.viewState
            .eraseToAnyPublisher()
            .sink{ [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .sendToggle :
                    if(viewModel.isScrollup){
                        collectionViewHeightConstraint.constant = 120
                        arrowIcon.image = UIImage(systemName: "chevron.compact.down")
                    }
                    else{
                        collectionViewHeightConstraint.constant = 220
                        arrowIcon.image = UIImage(systemName: "chevron.compact.up")

                    }
                case .refresh:
                    tableView.reloadData()
                    collectionView.reloadData()

                }
    
                
            }.store(in: &cancellables)
    }
    
    @objc private func handleScroll(){
        viewModel.handleDropDownArrow()
        
       
    }
    
    // MARK: setupCollectionView
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.registerForCell(identifier: CategoryCVCell.identifier)
        
    }
    
    // MARK: setupaTableView
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        
        // Register TableView Cell
        tableView.registerForCell(identifier: CollectionTableViewCell.identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    func addCardShadow(to view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 5
    }
     
    
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = viewModel.items[indexPath.section]
        switch itemType{
        case .Slider:
            let cell =  tableView.dequeueCell(identifier: CollectionTableViewCell.identifier, indexPath: indexPath) as CollectionTableViewCell
            cell.setSlider(data: viewModel.categoryList)
            
            return cell
        case .Promotion:
            let cell =  tableView.dequeueCell(identifier: CollectionTableViewCell.identifier, indexPath: indexPath) as CollectionTableViewCell
            cell.setPromotion(data: viewModel.categoryList)
            return cell
            
        case .NewLetter :
            let cell =  tableView.dequeueCell(identifier: CollectionTableViewCell.identifier, indexPath: indexPath) as CollectionTableViewCell
            cell.setNewLetter(data: viewModel.articleList)
            return cell
        case .Announcement:
            let cell =  tableView.dequeueCell(identifier: CollectionTableViewCell.identifier, indexPath: indexPath) as CollectionTableViewCell
            cell.setAnnouncement(data: viewModel.categoryList)
            return cell
        }
       
    }
    

    
}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return categoryList.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: CategoryCVCell.identifier, indexPath: indexPath) as CategoryCVCell
        cell.category = categoryList[indexPath.row]
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = collectionView.frame.width / 4
        return CGSize(width: itemWidth, height: 100)


    }


}

