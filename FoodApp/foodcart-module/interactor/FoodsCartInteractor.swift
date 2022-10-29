//
//  FoodsCartInteractor.swift
//  FoodApp
//
//  Created by Burak Ertaş on 23.10.2022.
//

import Foundation
import Alamofire

class FoodsCartInteractor: PresenterToInteractorFoodsCartProtocol {
    var foodsCartPresenter: InteractorToPresenterFoodsCartProtocol?
    
    func getAllFoods(kullanici_adi: String) {
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(CartResult.self, from: data)
                    if let list = result.sepet_yemekler {
                        self.foodsCartPresenter?.sendDataToPresenter(cartList: list)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteFood(sepet_yemek_id: Int, kullanici_adi: String) {
        let params : Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                    DispatchQueue.main.async {
                        self.getAllFoods(kullanici_adi: kullanici_adi)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteAllCart(allCart: Array<Cart>, kullanici_adi: String) {
        for cartItem in allCart {
            DispatchQueue.main.async { [weak self] in
                self?.deleteFood(sepet_yemek_id: Int(cartItem.sepet_yemek_id!)!, kullanici_adi: kullanici_adi)
            }
        }
    }
    
    
}
