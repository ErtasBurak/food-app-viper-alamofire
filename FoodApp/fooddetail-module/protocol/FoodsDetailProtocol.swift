//
//  FoodsDetailProtocol.swift
//  FoodApp
//
//  Created by Burak Ertaş on 22.10.2022.
//

import Foundation

protocol ViewToPresenterFoodsDetailProtocol {
    var foodDetailInteractor: PresenterToInteractorFoodsDetailProtocol? {get set}
    
    func add(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
}

protocol PresenterToInteractorFoodsDetailProtocol {
    func foodAdd(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
}

protocol PresenterToRouterFoodsDetailProtocol {
    static func createModule(ref: FoodDetailVC)
}
