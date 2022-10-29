//
//  FoodsCartProtocol.swift
//  FoodApp
//
//  Created by Burak Ertaş on 23.10.2022.
//

import Foundation

protocol ViewToPresenterFoodsCartProtocol {
    var foodsCartInteractor: PresenterToInteractorFoodsCartProtocol? {get set}
    var foodsCartView: PresenterToViewFoodsCartProtocol? {get set}
    
    func getFoods(kullanici_adi: String)
    func delete(sepet_yemek_id: Int, kullanici_adi: String)
    func deleteAll(allCart: Array<Cart>, kullanici_adi: String)
}

protocol PresenterToInteractorFoodsCartProtocol {
    var foodsCartPresenter: InteractorToPresenterFoodsCartProtocol? {get set}
    
    func getAllFoods(kullanici_adi: String)
    func deleteFood(sepet_yemek_id: Int, kullanici_adi: String)
    func deleteAllCart(allCart: Array<Cart>, kullanici_adi: String)
}

protocol InteractorToPresenterFoodsCartProtocol {
    func sendDataToPresenter(cartList: [Cart])
}

protocol PresenterToViewFoodsCartProtocol {
    func sendDataToView(cartList: [Cart])
}

protocol PresenterToRouterFoodsCartProtocol {
    static func createModule(ref: FoodCartVC)
}
