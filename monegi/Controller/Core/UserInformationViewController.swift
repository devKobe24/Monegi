//
//  UserInformationViewController.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

final class UserInformationViewController: UIViewController {
    
    let headerView: UIView = UIView()
    let githubRepoAndGistView: UIView = UIView()
    let getFollowerAndFollowingView: UIView = UIView()
    let dateLabel: MGBodyLabel = MGBodyLabel(textAlignment: .center)
    
    var networkManager: NetworkManager
    var username: String?
    weak var delegate: FollowerListViewControllerDelegate?
    
    init(networkManager: NetworkManager, username: String?) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
        setupHeaderView()
        setupGithubRepoView()
        setupGitgistView()
        setUpDoneButton()
        setupDateLabel()
        
        getUserInfo()
    }
}

extension UserInformationViewController {
    
    private func getUserInfo() {
        guard let username = self.username else { return }
        
        networkManager.getUserInfo(username: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userData):
                DispatchQueue.main.async {
                    self.setupUIElements(with: userData)
                }
            case .failure(let error):
                presentMGAlert(alertTitle: "Error", message: error.localizedDescription, buttonTitle: "OK")
            }
        }
    }
}

extension UserInformationViewController {
    
    private func setupUIElements(with userData: User) {
        let repoAndGistItemViewController = MGRepoAndGistItemViewController(userData: userData)
        repoAndGistItemViewController.delegate = self
        
        let followerAndFollowingViewController = MGFollowerAndFollowingViewController(userData: userData)
        followerAndFollowingViewController.delegate = self
        
        self.add(childViewController: MGUserInfoHeaderViewController(userData: userData), to: self.headerView)
        self.add(childViewController: repoAndGistItemViewController, to: self.githubRepoAndGistView)
        self.add(childViewController: followerAndFollowingViewController, to: self.getFollowerAndFollowingView)
        self.dateLabel.text = "Github since \(userData.createdAt.convertDateToDisplayFormat())"
    }
}

extension UserInformationViewController {
    
    private func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}

extension UserInformationViewController {
    
    private func setupHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        headerView.backgroundColor = .systemBackground
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        let height = (view.frame.height) - (view.frame.height - 180)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupGithubRepoView() {
        githubRepoAndGistView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(githubRepoAndGistView)
        
        configureGithubRepoView()
    }
    
    private func configureGithubRepoView() {
        let height = (view.bounds.height) - (view.bounds.height - 140)
        
        NSLayoutConstraint.activate([
            githubRepoAndGistView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            githubRepoAndGistView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            githubRepoAndGistView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            githubRepoAndGistView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupGitgistView() {
        getFollowerAndFollowingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(getFollowerAndFollowingView)
        
        configureGitgistView()
    }
    
    private func configureGitgistView() {
        let height = (view.bounds.height) - (view.bounds.height - 140)
        
        NSLayoutConstraint.activate([
            getFollowerAndFollowingView.topAnchor.constraint(equalTo: githubRepoAndGistView.bottomAnchor, constant: 20),
            getFollowerAndFollowingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getFollowerAndFollowingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            getFollowerAndFollowingView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setUpDoneButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dimissUserInformationViewController))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func dimissUserInformationViewController() {
        dismiss(animated: true)
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        
        configureDateLabel()
    }
    
    private func configureDateLabel() {
        let height = (view.bounds.height) - (view.bounds.height-18)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: getFollowerAndFollowingView.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}

extension UserInformationViewController {
    private func initialSetup() {
        view.backgroundColor = .systemBackground
    }
}

extension UserInformationViewController: UserInformationDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentMGAlert(alertTitle: "유효하지 않은 URL", message: "이 URL은 유효하지 않은 URL입니다.", buttonTitle: "OK")
            return
        }
        presentSafariViewController(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentMGAlert(alertTitle: "팔로워가 없습니다.", message: "이 유저는 팔로워가 없습니다.", buttonTitle: "OK")
            return
        }
        delegate?.didRequestFollowers(for: user.login)
        self.dismiss(animated: true)
    }
}
