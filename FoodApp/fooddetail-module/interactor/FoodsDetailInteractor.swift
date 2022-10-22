//
//  FoodsDetailInteractor.swift
//  FoodApp
//
//  Created by Burak Ertaş on 22.10.2022.
//

import Foundation
import Alamofire

class FoodsDetailInteractor: PresenterToInteractorFoodsDetailProtocol {
    
    func foodAdd(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        
        let params: Parameters = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
}
