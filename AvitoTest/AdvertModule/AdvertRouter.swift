//
//  AdvertRouter.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 17.01.2021.
//

import Foundation

final class AdvertRouter: AdvertRouterProtocol {
    weak var viewController: AdvertViewProtocol!
    
    required init(viewController: AdvertViewProtocol) {
        self.viewController = viewController
    }
}
