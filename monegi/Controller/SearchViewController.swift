//
//  SearchViewController.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

import UIKit
import OSLog

final class SearchViewController: UIViewController {
    private let logger: Logger = Logger()
    private var networkManager: NetworkManager
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
//        fetchListRepository(owner: "devKobe24", repo: "TIL")
        fetchListPublicRepository(username: "devKobe24")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        configureLogoImageView()
    }
}

extension SearchViewController {
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: ImageContents.mgLogo.asset)
        configureLogoImageViewUI()
    }
    
    private func configureLogoImageViewUI() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.53/3),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1)
        ])
    }
}

extension SearchViewController {
    private func fetchListRepository(owner: String, repo: String) {
        networkManager.fetchListRepositoryData(owner: owner, repo: repo) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                self.logger.debug("\(error.localizedDescription)")
            }
        }
    }
}

extension SearchViewController {
    private func fetchListPublicRepository(username: String) {
        networkManager.fetchListPublicRepositoryData(username: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                self.logger.debug("\(error.localizedDescription)")
            }
        }
    }
}

