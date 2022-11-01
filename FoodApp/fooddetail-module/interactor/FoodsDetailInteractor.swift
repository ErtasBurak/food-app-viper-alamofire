//
//  FoodsDetailInteractor.swift
//  FoodApp
//
//  Created by Burak Ertaş on 22.10.2022.
//

import Foundation
import Alamofire

class FoodsDetailInteractor: PresenterToInteractorFoodsDetailProtocol {
    var foodAtCart = [Cart]()
    
    
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
    
    func deleteFood(sepet_yemek_id: Int, kullanici_adi: String) {
        let params : Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
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
    
    func cartControlAdd(food: Foods, count: Int, username: String, addPrice: Int) {
        var sameFood: Cart?
        
        getCart(username: username) {
            sameFood = self.foodCartControl(food: food)
            
            if sameFood != nil {
                let oldCount = sameFood?.yemek_siparis_adet
                let oldPrice = sameFood?.yemek_fiyat
                let addCount = count
                let addPrice = addPrice
                
                sameFood?.yemek_siparis_adet = String(Int(oldCount!)! + addCount)
                sameFood?.yemek_fiyat = String(Int(addPrice) + Int(oldPrice!)!)
                
                
                self.deleteFood(sepet_yemek_id: Int((sameFood?.sepet_yemek_id)!)!, kullanici_adi: username)
                let newFood = Foods(yemek_id: "", yemek_adi: (sameFood?.yemek_adi)!, yemek_resim_adi: (sameFood?.yemek_resim_adi)!, yemek_fiyat: (sameFood?.yemek_fiyat)!)
                    
                self.foodAdd(yemek_adi: newFood.yemek_adi!, yemek_resim_adi: newFood.yemek_resim_adi!, yemek_fiyat: Int((newFood.yemek_fiyat)!)!, yemek_siparis_adet: Int(sameFood!.yemek_siparis_adet!)!, kullanici_adi: username)
                
            }else{
                self.foodAdd(yemek_adi: food.yemek_adi!, yemek_resim_adi: food.yemek_resim_adi!, yemek_fiyat: addPrice, yemek_siparis_adet: count, kullanici_adi: username)
            }
        }
        
    }
    
    func getCart(username: String, completion: @escaping () -> Void) {
        let params: Parameters = ["kullanici_adi": username]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(CartResult.self, from: data)
                    print(data)
                    if let list = response.sepet_yemekler {
                        DispatchQueue.main.async {
                            self.foodAtCart = list
                            completion()
                        }
                    }
            }catch{
                print(error.localizedDescription)
                completion()
                }
            }
        }
    }
    
    func foodCartControl(food: Foods) -> Cart? {
        let sameFood = foodAtCart.first {$0.yemek_adi == food.yemek_adi}
        if sameFood != nil {
            return sameFood!
        }
        return nil
    }
    
}
