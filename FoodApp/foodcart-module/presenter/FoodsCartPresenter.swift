//
//  FoodsCartPresenter.swift
//  FoodApp
//
//  Created by Burak Ertaş on 23.10.2022.
//

import Foundation

class FoodsCartPresenter: ViewToPresenterFoodsCartProtocol {
    var foodsCartInteractor: PresenterToInteractorFoodsCartProtocol?
    
    var foodsCartView: PresenterToViewFoodsCartProtocol?
    
    func getFoods(kullanici_adi: String) {
        foodsCartInteractor?.getAllFoods(kullanici_adi: kullanici_adi)
    }
    
    func delete(sepet_yemek_id: Int, kullanici_adi: String) {
        foodsCartInteractor?.deleteFood(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func deleteAll(allCart: Array<Cart>, kullanici_adi: String){
        foodsCartInteractor?.deleteAllCart(allCart: allCart, kullanici_adi: kullanici_adi)
    }
    
}

extension FoodsCartPresenter: InteractorToPresenterFoodsCartProtocol {
    func sendDataToPresenter(cartList: [Cart]) {
        foodsCartView?.sendDataToView(cartList: cartList)
    }
}
