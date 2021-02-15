//
//  AdvertProtocols.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 17.01.2021.
//

import UIKit

protocol AdvertViewProtocol: class {
    func setupCollectionView()
    func setupNavBarLeftButton()
    func reloadData()
    func reloadItem(at index: IndexPath)
    func reloadItems(at index: [IndexPath])
}

protocol AdvertPresenterProtocol: class {
    var router: AdvertRouterProtocol! { set get }
    func configurateView()
    func advertOptionsCount() -> Int
    func updateCollectionViewCells()
    func reloadItem(at index: IndexPath)
    func reloadItems(at index: [IndexPath])
    func getAdvertOption(at index: IndexPath) -> AdvertOption?
    func didDisappear(at index: IndexPath)
    func getTitle() -> String
    func configSelected()
    func setSelected(at index: IndexPath)
}

protocol AdvertInteractorProtocol: class {
    func loadAdvertOptions()
    func optionsCount() -> Int?
    func getOptions() -> [AdvertOption]?
    func loadIcon(at index: IndexPath)
    func cancelLoad(at index: IndexPath)
    func getModel() -> AdvertModel?
}

protocol AdvertRouterProtocol: class {
    
}

protocol AdvertConfiguratorProtocol: class {
    func configurate(with viewController: AdvertViewController)
}
