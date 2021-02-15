//
//  AdvertConfigurator.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 17.01.2021.
//

import UIKit

final class AdvertConfigurator: AdvertConfiguratorProtocol {
    
    func configurate(with viewController: AdvertViewController) {
        let presenter = AdvertPresenter(view: viewController)
        let interactor = AdvertInteractor(presenter: presenter)
        let router = AdvertRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
