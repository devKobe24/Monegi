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
    
    private let usernameTextField: MGTextField = {
        let textField = MGTextField()
        
        return textField
    }()
    
    private let searchUserButton: MGButton = {
        let button = MGButton(backgroundColor: .systemGreen,
                              title: "Search User")
        
        return button
    }()
    
    private var isUsernameEmpty: Bool {
        guard let username = usernameTextField.text else {
            return false
        }
        
        switch username {
        case "":
            return false
        default:
            return true
        }
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
//        fetchListRepository(owner: "devKobe24", repo: "TIL")
//        fetchListPublicRepository(username: "devKobe24")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupLogoImageView()
        setupUsernameTextField()
        setupSearchUserButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension SearchViewController {
    
    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: Image(image: .mgLogo).image.asset)
        
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
    
    private func setupUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        configureUserTextFieldUI()
    }
    
    private func configureUserTextFieldUI() {
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1.5),
            usernameTextField.heightAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1/4)
        ])
    }
    
    private func setupSearchUserButton() {
        view.addSubview(searchUserButton)
        searchUserButton.addTarget(self, action: #selector(pushFollowerListViewController), for: .touchUpInside)
        
        configureSearchUserButtonUI()
    }
    
    private func configureSearchUserButtonUI() {
        NSLayoutConstraint.activate([
            searchUserButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchUserButton.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor, multiplier: 1),
            searchUserButton.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor, multiplier: 1)
        ])
    }
    
    @objc private func pushFollowerListViewController() {
        
        guard isUsernameEmpty else {
            presentMGAlert(alertTitle: "유저의 이름을 입력해주세요🥲",
                           message: "검색을 원하는 유저의 이름을 입력해주세요, 제가 찾아드릴게요😆",
                           buttonTitle: "OK")
            logger.debug("Empty Username")
            return
        }
        
        guard let username = usernameTextField.text else { return }
        
        let followerListViewController = FollowerListViewController(username: username, networkManager: self.networkManager)
        followerListViewController.title = username
        navigationController?.pushViewController(followerListViewController, animated: true)
    }
}

extension SearchViewController {
    
    private func createDismissKeyboardTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self.view,
            action: #selector(UIView.endEditing)
        )
        view.addGestureRecognizer(tapGestureRecognizer)
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

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListViewController()
        
        return true
    }
}
