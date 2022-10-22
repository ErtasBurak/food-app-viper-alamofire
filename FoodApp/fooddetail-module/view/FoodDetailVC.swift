//
//  DetailScreenVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 18.10.2022.
//

import UIKit
import Kingfisher

class FoodDetailVC: UIViewController {

    @IBOutlet weak var foodsDetailName: UILabel!
    @IBOutlet weak var foodsDetailPrice: UILabel!
    @IBOutlet weak var foodsDetailImage: UIImageView!
    @IBOutlet weak var foodsDetailStepper: GMStepper!
    
    var foodDetailPresenterInstance: ViewToPresenterFoodsDetailProtocol?
    
    var userName : String? = "burak_ertas"
    
    var food: Foods?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FoodsDetailRouter.createModule(ref: self)

        if let f = food {
            foodsDetailName.text = f.yemek_adi
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.foodsDetailImage.kf.setImage(with: url)
                }
            }
            foodsDetailPrice.text = "\(Int(f.yemek_fiyat!)! * Int(foodsDetailStepper.value)) ₺"
        }
        
    }
    @IBAction func foodPriceChange(_ sender: Any) {
        let res = Int(foodsDetailStepper.value) * Int(food!.yemek_fiyat!)!
        foodsDetailPrice.text = "\(res) ₺"
    }
    
    
    
    @IBAction func foodsDetailButton(_ sender: Any) {
        let res : Int? = Int(foodsDetailStepper.value) * Int(food!.yemek_fiyat!)!
        if let fdn = foodsDetailName.text, let fdi = food?.yemek_resim_adi, let fdp = res, let fds = foodsDetailStepper, let usern = userName {
            foodDetailPresenterInstance?.add(yemek_adi: fdn, yemek_resim_adi: fdi, yemek_fiyat: Int(fdp), yemek_siparis_adet: Int(fds.value), kullanici_adi: String(usern))
        }
    }
    
}
