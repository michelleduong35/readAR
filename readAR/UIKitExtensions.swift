//
//  UIKitExtensions.swift
//  readAR
//
//  Created by Michelle Duong on 4/22/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}
