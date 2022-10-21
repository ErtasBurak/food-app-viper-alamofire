//
//  FoodsMainInteractor.swift
//  FoodApp
//
//  Created by Burak Ertaş on 21.10.2022.
//

import Foundation
import Alamofire

class FoodsMainInteractor: PresenterToInteractorFoodsMainProtocol {
    var foodsMainPresenter: InteractorToPresenterFoodsMainProtocol?
    
    func getAllFoods() {
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(FoodsResult.self, from: data)
                    if let list = result.yemekler {
                        
                        self.foodsMainPresenter?.sendDataToPresenter(foodsList: list)
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func foodSearch(searchWord: String) {
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(FoodsResult.self, from: data)
                    if var list = result.yemekler {
                        
                        if searchWord == "" {
                            self.foodsMainPresenter?.sendDataToPresenter(foodsList: list)
                        }else {
                            list = list.filter({ data_ -> Bool in
                                (data_.yemek_adi?.lowercased().contains(searchWord.lowercased()))!
                            })
                            self.foodsMainPresenter?.sendDataToPresenter(foodsList: list)
                        }
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
