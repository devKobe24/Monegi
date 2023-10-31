//
//  FollowerListViewController.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

final class FollowerListViewController: UIViewController {
    
    var username: String
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    let networkManager: NetworkManager
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>?
    var page: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearchingUsername: Bool = false
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout().configureFlowLayout(in: view)
        
        var collectionView = UICollectionView(
            frame: self.view.bounds,
            collectionViewLayout: flowLayout
        )
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        
        return collectionView
    }()
    
    init(username: String, networkManager: NetworkManager) {
        self.username = username
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFollowerListViewController()
        setupCollectionView()
        getFollower(username: username, page: page)
        configureDataSource()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension FollowerListViewController {
    
    private func setupFollowerListViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension FollowerListViewController {
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
}

extension FollowerListViewController {
    
    private func getFollower(username: String, page: Int) {
        showLoadingView { [weak self] (activityIndicator, containerView) in
            guard let self = self else { return }
            
            self.networkManager.getFollower(
                username: username,
                perPage: 100,
                page: page
            ) { result in
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    containerView.removeFromSuperview()
                }
                switch result {
                case .success(let followers):
                    if followers.count < 100 {
                        self.hasMoreFollowers = false
                    }
                    self.followers.append(contentsOf: followers)
                    
                    if self.followers.isEmpty {
                        let message = "이 유저는 팔로워가 없습니다 😅"
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        return
                    }
                    self.updateData(on: self.followers)
                    
                case .failure(let error):
                    self.presentMGAlert(
                        alertTitle: "😅ERROR😅",
                        message: error.localizedDescription,
                        buttonTitle: "OK"
                    )
                }
            }
        }
    }
}

extension FollowerListViewController {
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerCell.reuseIdentifier,
                    for: indexPath
                ) as? FollowerCell else {
                    return UICollectionViewCell()
                }
                
                cell.setup(follower: follower)
                
                return cell
            }
        )
    }
}

extension FollowerListViewController {
    
    private func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        
        self.dataSource?.apply(
            snapShot,
            animatingDifferences: true,
            completion: nil
        )
    }
}

extension FollowerListViewController {
    
    private func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
}


extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollower(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let items = isSearchingUsername ? filteredFollowers : followers
        let selectedFollower = items[indexPath.item]
        
        let userInformationViewController = UserInformationViewController(
            networkManager: self.networkManager,
            username: selectedFollower.login
        )
        
        userInformationViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: userInformationViewController)
        present(navigationController, animated: true)
    }
}

extension FollowerListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchingUsername = false
        
        updateData(on: self.followers)
    }
}

extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,
              !filter.isEmpty,
              filter != "" else {
            return
        }
        
        isSearchingUsername = true
        
        filteredFollowers = followers.filter({ follwers in
            follwers.login.lowercased().contains(filter.lowercased())
        })
        
        updateData(on: filteredFollowers)
    }
}

extension FollowerListViewController: FollowerListViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollower(username: username, page: page)
    }
}
