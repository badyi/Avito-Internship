//
//  AdvertPresenter.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 17.01.2021.
//

import Foundation

final class AdvertPresenter: AdvertPresenterProtocol {
    
    var router: AdvertRouterProtocol!
    weak var view: AdvertViewProtocol!
    var interactor: AdvertInteractorProtocol!
    
    required init(view: AdvertViewProtocol) {
        self.view = view
    }
    

    func updateCollectionViewCells() {
        DispatchQueue.main.async {
            for i in 0..<self.advertOptionsCount() {
                self.reloadItem(at: IndexPath(row: i, section: 0))
            }
        }
    }
    
    func reloadItem(at index: IndexPath) {
        DispatchQueue.main.async {
            self.view.reloadItem(at: index)
        }
    }
    
    func configurateView() {
        view.setupCollectionView()
        view.setupNavBarLeftButton()
        interactor.loadAdvertOptions()
    }
    
    func advertOptionsCount() -> Int {
        return interactor.optionsCount() ?? 0
    }
    
    func getAdvertOption(at index: IndexPath) -> AdvertOption? {
        guard let options = interactor.getOptions() else {
            return nil
        }
        interactor.loadIcon(at: index)
        return options[index.row]
    }
    
    func didDisappear(at index: IndexPath) {
        interactor.cancelLoad(at: index)
    }
    
    func getTitle() -> String {
        interactor.getModel()?.title ?? ""
    }
    
    func configSelected() {
        var indexRow: Int = 0
        if let options = interactor.getOptions() {
            for (row, i) in options.enumerated() {
                if i.isSelected == true {
                    indexRow = row
                }
            }
            for (row, i) in options.enumerated() {
                if row != indexRow {
                    i.isSelected = false
                }
            }
        }
    }
    
    func setSelected(at index: IndexPath) {
        var prevSelected: Int = 0
        if let options = interactor.getOptions() {
            for (row, i) in options.enumerated() {
                if i.isSelected == true {
                    prevSelected = row
                    i.isSelected = false
                    break
                }
            }
            options[index.row].isSelected = true
        }
        reloadItems(at: [IndexPath(row: prevSelected, section: index.section), index])
    }
    
    func reloadItems(at index: [IndexPath]) {
        view.reloadItems(at: index)
    }
}
