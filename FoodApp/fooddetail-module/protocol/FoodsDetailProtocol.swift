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
    func delete(sepet_yemek_id: Int, kullanici_adi: String)
    func foodAddControl(food: Foods, count: Int, username: String, addPrice: Int)
}

protocol PresenterToInteractorFoodsDetailProtocol {
    func foodAdd(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
    func deleteFood(sepet_yemek_id: Int, kullanici_adi: String)
    func cartControlAdd(food: Foods, count: Int, username: String, addPrice: Int)
}

protocol PresenterToRouterFoodsDetailProtocol {
    static func createModule(ref: FoodDetailVC)
}
