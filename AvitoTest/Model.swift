//
//  Model.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 18.01.2021.
//

import Foundation

final class AdvertModel {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    var options: [AdvertOption]
    
    
    init(_ title: String,_ actionTitle: String,_ selectedActionTitle: String,_ options: [AdvertOption]) {
        self.title = title
        self.actionTitle = actionTitle
        self.selectedActionTitle = selectedActionTitle
        self.options = [AdvertOption]()
        for i in options {
            self.options.append(AdvertOption(i.id, i.title, i.description, i.iconURLString, i.price, i.isSelected))
        }
    }
}

final class AdvertOption {
    let id: String
    let title: String
    let description: String?
    var iconURLString: String
    let price: String
    var isSelected: Bool
    var image: Data?
    var task: URLSessionDataTask?
    
    init(_ id: String,_ title: String,_ description: String?,_ iconURLString: String,_ price: String,_ isSelected: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.iconURLString = iconURLString
        self.price = price
        self.isSelected = isSelected
    }
}

extension AdvertOption {
    func downloadImage(completion: @escaping(Bool) -> ()) {
        guard image == nil else {
            return
        }
        
        guard let url = URL(string: self.iconURLString) else {
            print("error. AdvertOption modul. url error")
            return
        }
        
        getData(from: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            self?.image = data
            completion(true)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        task = URLSession.shared.dataTask(with: url, completionHandler: completion)
        task?.resume()
    }
    
    func cancelLoad() {
        task?.cancel()
    }
}
