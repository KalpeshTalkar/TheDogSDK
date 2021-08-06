//
//  ImageLoader.swift
//  DemoApp
//
//  Created by Kalpesh on 24/04/21.
//

import UIKit

class ImageLoader {

    public static let shared = ImageLoader()

    private init() { }

    private var imageCache = [String : UIImage]()

    /// Load image from url.
    /// - Parameters:
    ///   - url: URL of the image.
    ///   - completion: Result block.
    func getImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if let image = imageCache[url] {
            completion(image)
        } else {
            guard let url = URL(string: url) else {
                completion(nil)
                return
            }

            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let responseData = data,
                      let image = UIImage(data: responseData) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                self.imageCache[url.absoluteString] = image
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
    }

}

extension UIImageView {

    /// Set image from url.
    /// - Parameters:
    ///   - url: URL of the image.
    ///   - defaultImage: (Optional) Default image.
    ///   - completion: (Optional) Result block.
    func setImage(url: String, defaultImage: UIImage? = nil, completion: ((UIImage?) -> Void)? = nil) {
        self.image = defaultImage
        ImageLoader.shared.getImage(url: url) { [weak self] (image) in
            guard let self = self else { return }
            if let image = image {
                self.image = image
            } else {
                self.image = defaultImage
            }
            completion?(image)
        }
    }

}
