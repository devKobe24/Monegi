//
//  MGAvatarImageView.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit
import OSLog

final class MGAvatarImageView: UIImageView {
    let downloadImageManager: DownloadImageManager = DownloadImageManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureMGAvatarImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MGAvatarImageView {
    private func configureMGAvatarImageView() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension MGAvatarImageView {
    func set(placeHolderImage: UIImage) {
        image = placeHolderImage
    }
    
    func downloadImage(from urlString: String) {
        downloadImageManager.downloadImage(
            from: urlString
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let downloadImage):
                DispatchQueue.main.async {
                    self.image = downloadImage
                }
            case .failure(let error):
                Logger().debug("\(error.localizedDescription) 발생.")
            }
        }
    }
}
