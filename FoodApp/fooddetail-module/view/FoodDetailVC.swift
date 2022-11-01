//
//  DetailScreenVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 18.10.2022.
//

import UIKit
import Kingfisher
import Firebase

class FoodDetailVC: UIViewController {

    @IBOutlet weak var foodsDetailName: UILabel!
    @IBOutlet weak var foodsDetailPrice: UILabel!
    @IBOutlet weak var foodsDetailImage: UIImageView!
    @IBOutlet weak var foodsDetailStepper: GMStepper!
    @IBOutlet weak var foodAddbutton: UIButton!
    
    var foodDetailPresenterInstance: ViewToPresenterFoodsDetailProtocol?
    
    var userName : String? = "\((Firebase.Auth.auth().currentUser?.email)!)"
    
    var cartList = [Cart]()
    
    var food: Foods?
    
    var cart: Cart?
    
    var basicPrice: Int?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FoodsDetailRouter.createModule(ref: self)
        
        self.navigationItem.setHidesBackButton(true, animated: false)

        //get the data from main screen
        if let f = food {
            foodsDetailName.text = f.yemek_adi
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.foodsDetailImage.kf.setImage(with: url)
                }
            }
            foodsDetailPrice.text = "\(Int(f.yemek_fiyat!)! * Int(foodsDetailStepper.value)) ₺"
        }
        
        //get the data from cart screen
        if let c = cart {
            foodAddbutton.setTitle(String(localized: "updatebutton_id"), for: .normal)
            foodsDetailName.text = c.yemek_adi
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(c.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.foodsDetailImage.kf.setImage(with: url)
                }
            }
            foodsDetailPrice.text = "\(basicPrice!  * Int(foodsDetailStepper.value)) ₺"
            foodsDetailStepper.value = Double(Int(c.yemek_siparis_adet!)!)
            
        }
        
    }
    
    @IBAction func foodPriceChange(_ sender: Any) {
        if cart != nil {
            let res = basicPrice! * Int(foodsDetailStepper.value)
            foodsDetailPrice.text = "\(res) ₺"
        }else{
            let res = Int(foodsDetailStepper.value) * Int(food!.yemek_fiyat!)!
            foodsDetailPrice.text = "\(res) ₺"
        }
        
    }
    
    @IBAction func foodsDetailButton(_ sender: Any) {
        
        if cart != nil {
            let res : Int? = Int(foodsDetailStepper.value) * basicPrice!
            if let fdn = foodsDetailName.text, let fdi = cart?.yemek_resim_adi, let fdp = res, let fds = foodsDetailStepper, let usern = userName, let cartFoodId = cart?.sepet_yemek_id {
                foodDetailPresenterInstance?.delete(sepet_yemek_id: Int(cartFoodId)!, kullanici_adi: usern)
                foodDetailPresenterInstance?.add(yemek_adi: fdn, yemek_resim_adi: fdi, yemek_fiyat: Int(fdp), yemek_siparis_adet: Int(fds.value), kullanici_adi: usern)
                
            }
        }else{
            let res : Int? = Int(foodsDetailStepper.value) * Int(food!.yemek_fiyat!)!
            if let fdn = foodsDetailName.text, let fdi = food?.yemek_resim_adi, let fdp = res, let fds = foodsDetailStepper, let usern = userName {
                //foodDetailPresenterInstance?.add(yemek_adi: fdn, yemek_resim_adi: fdi, yemek_fiyat: Int(fdp), yemek_siparis_adet: Int(fds.value), kullanici_adi: usern)
                foodDetailPresenterInstance?.foodAddControl(food: food!, count: Int(fds.value), username: usern, addPrice: fdp)
            }
        }
        
        dismiss(animated: true)
        
    }
    
}
