//
//  FoodsDetailPresenter.swift
//  FoodApp
//
//  Created by Burak Ertaş on 22.10.2022.
//

import Foundation

class FoodsDetailPresenter: ViewToPresenterFoodsDetailProtocol {
    var foodDetailInteractor: PresenterToInteractorFoodsDetailProtocol?
    
    func add(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        foodDetailInteractor?.foodAdd(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    func foodAddControl(food: Foods, count: Int, username: String, addPrice: Int) {
        foodDetailInteractor?.cartControlAdd(food: food, count: count, username: username, addPrice: addPrice)
    }
    
    func delete(sepet_yemek_id: Int, kullanici_adi: String) {
        foodDetailInteractor?.deleteFood(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
}
