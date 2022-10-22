//
//  FoodsDetailRouter.swift
//  FoodApp
//
//  Created by Burak Ertaş on 22.10.2022.
//

import Foundation

class FoodsDetailRouter: PresenterToRouterFoodsDetailProtocol {
    
    static func createModule(ref: FoodDetailVC) {
        
        ref.foodDetailPresenterInstance = FoodsDetailPresenter()
        
        ref.foodDetailPresenterInstance?.foodDetailInteractor = FoodsDetailInteractor()
        
    }
    
}
