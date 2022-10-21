//
//  FoodsMainPresenter.swift
//  FoodApp
//
//  Created by Burak Ertaş on 21.10.2022.
//

import Foundation

class FoodsMainPresenter: ViewToPresenterFoodsMainProtocol {
    
    var foodsMainInteractor: PresenterToInteractorFoodsMainProtocol?
    
    var foodsMainView: PresenterToViewFoodsMainProtocol?
    
    func foodsGet() {
        foodsMainInteractor?.getAllFoods()
    }
    
    func search(searchWord: String) {
        foodsMainInteractor?.foodSearch(searchWord: searchWord)
    }
    
}

extension FoodsMainPresenter: InteractorToPresenterFoodsMainProtocol {
    
    func sendDataToPresenter(foodsList: [Foods]) {
        foodsMainView?.sendDataToView(foodsList: foodsList)
    }
    
}
