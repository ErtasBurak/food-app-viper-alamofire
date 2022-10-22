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
    
}
