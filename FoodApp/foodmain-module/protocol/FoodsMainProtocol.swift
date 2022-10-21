//
//  FoodsMainProtocol.swift
//  FoodApp
//
//  Created by Burak Ertaş on 21.10.2022.
//

import Foundation

protocol ViewToPresenterFoodsMainProtocol {
    var foodsMainInteractor: PresenterToInteractorFoodsMainProtocol? {get set}
    var foodsMainView: PresenterToViewFoodsMainProtocol? {get set}
    
    func foodsGet()
    func search(searchWord: String)
}

protocol PresenterToInteractorFoodsMainProtocol {
    var foodsMainPresenter: InteractorToPresenterFoodsMainProtocol? {get set}
    
    func getAllFoods()
    func foodSearch(searchWord:String)
}

protocol InteractorToPresenterFoodsMainProtocol {
    func sendDataToPresenter(foodsList: [Foods])
}

protocol PresenterToViewFoodsMainProtocol {
    func sendDataToView(foodsList: [Foods])
}

protocol PresenterToRouterFoodsMainProtocol {
    static func createModule(ref: FoodMainVC)
}
