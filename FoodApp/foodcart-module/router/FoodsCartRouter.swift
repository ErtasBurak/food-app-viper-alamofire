//
//  FoodsCartRouter.swift
//  FoodApp
//
//  Created by Burak Ertaş on 23.10.2022.
//

import Foundation

class FoodsCartRouter: PresenterToRouterFoodsCartProtocol {
    static func createModule(ref: FoodCartVC) {
        let presenter = FoodsCartPresenter()
        
        ref.foodsCartPresenterInstance = presenter
        
        ref.foodsCartPresenterInstance?.foodsCartInteractor = FoodsCartInteractor()
        ref.foodsCartPresenterInstance?.foodsCartView = ref
        
        ref.foodsCartPresenterInstance?.foodsCartInteractor?.foodsCartPresenter = presenter
    }
    
}
