//
//  ImageManager.swift
//  PokeBook
//
//  Created by 디해 on 2024/02/11.
//

import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private init () { }
    private var cache = NSCache<NSURL, UIImage>()
    
    func getImage(url: URL) async -> UIImage? {
        guard let image = cache.object(forKey: url as NSURL) else {
            do {
                let image = try await storeImage(url: url)
                return image
            } catch {
                print(error)
                return nil
            }
        }
        
        return image
    }
    
    func storeImage(url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { throw ErrorType.failDataToUIImage }
        cache.setObject(image, forKey: url as NSURL)
        return image
    }
}

extension ImageCacheManager {
    enum ErrorType: Error {
        case failDataToUIImage
    }
}
