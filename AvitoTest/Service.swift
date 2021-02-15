//
//  Service.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 18.01.2021.
//

import Foundation

final class Service {
    func readFromJson(fileName: String, completionBlock: @escaping(Response?) -> ()) -> () {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonDataResponse = try decoder.decode(Response.self, from: data)
                completionBlock(jsonDataResponse)
            } catch {
                print("error:\(error)")
                completionBlock(nil)
            }
        }
    }
    
}

extension URLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?) -> Void) -> URLSessionDataTask {
        dataTask(with: url){ (data, response, error) in
            if let data = data, error != nil {
                completionHandler(data)
            } else {
                completionHandler(data)
            }
        }
    }
}
struct Response: Codable {
    let status: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let title, actionTitle, selectedActionTitle: String
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let id, title: String
    let listDescription: String?
    let icon: Icon
    let price: String
    let isSelected: Bool

    enum CodingKeys: String, CodingKey {
        case id, title
        case listDescription = "description"
        case icon, price, isSelected
    }
}

// MARK: - Icon
struct Icon: Codable {
    let the52X52: String

    enum CodingKeys: String, CodingKey {
        case the52X52 = "52x52"
    }
}
