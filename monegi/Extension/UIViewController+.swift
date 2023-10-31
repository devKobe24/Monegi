//
//  UIViewController+.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentMGAlert(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = MGAlertViewController(alertTitle: alertTitle,
                                                            message: message,
                                                            buttonTitle: buttonTitle)
            
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
}

extension UIViewController {
    func showLoadingView(completionHandler: @escaping ((UIActivityIndicatorView, UIView) -> Void)) {
        let containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        completionHandler(activityIndicator, containerView)
    }
}

extension UIViewController {
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView: MGEmptyStateView = MGEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

extension UIViewController {
    func presentSafariViewController(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
}
