//
//  AdvertInteractor.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 17.01.2021.
//

import Foundation

final class AdvertInteractor: AdvertInteractorProtocol {
    
    private weak var presenter: AdvertPresenterProtocol!
    private var service: Service = Service()
    private var model: AdvertModel?
    
    required init(presenter: AdvertPresenterProtocol) {
        self.presenter = presenter
    }
    
    func loadAdvertOptions() {
        service.readFromJson(fileName: "result") { [weak self] result in
            if result != nil {
                let options: [AdvertOption] = result!.result.list.map { AdvertOption($0.id, $0.title, $0.listDescription, $0.icon.the52X52, $0.price, $0.isSelected) }
                self?.model = AdvertModel(result!.result.title, result!.result.actionTitle, result!.result.selectedActionTitle, options)
                self?.presenter.configSelected()
                self?.presenter.updateCollectionViewCells()
            } else {
                print("error")
            }
        }
    }
    
    func optionsCount() -> Int? {
        return model?.options.count
    }
    
    func getOptions() -> [AdvertOption]? {
        guard model != nil else {
            return nil
        }
        return model?.options
    }
    
    func getModel() -> AdvertModel? {
        return model
    }
    
    func loadIcon(at index: IndexPath) {
        guard model != nil else {
            return 
        }
        model?.options[index.row].downloadImage() { [weak self] flag in
            if flag {
                self?.presenter.reloadItem(at: index)
            } else {
                print("image didnt loaded")
            }
        }
    }
    
    func cancelLoad(at index: IndexPath) {
        guard model != nil else {
            return
        }
        model?.options[index.row].cancelLoad()
    }
}
