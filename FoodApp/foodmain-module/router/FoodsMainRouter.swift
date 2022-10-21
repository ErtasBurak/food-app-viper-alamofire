//
//  FoodsMainRouter.swift
//  FoodApp
//
//  Created by Burak Ertaş on 21.10.2022.
//

import Foundation

class FoodsMainRouter: PresenterToRouterFoodsMainProtocol {
    static func createModule(ref: FoodMainVC) {
        let presenter = FoodsMainPresenter()
        
        ref.foodsMainPresenterInstance = presenter
        
        ref.foodsMainPresenterInstance?.foodsMainInteractor = FoodsMainInteractor()
        ref.foodsMainPresenterInstance?.foodsMainView = ref
        
        ref.foodsMainPresenterInstance?.foodsMainInteractor?.foodsMainPresenter = presenter
    }
}
