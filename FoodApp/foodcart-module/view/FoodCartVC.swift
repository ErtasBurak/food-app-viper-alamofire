//
//  FoodAddScreenVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 18.10.2022.
//

import UIKit
import Kingfisher
import Firebase

class FoodCartVC: UIViewController {

    @IBOutlet weak var foodsCartOrder: UIButton!
    @IBOutlet weak var foodsCartTotal: UILabel!
    @IBOutlet weak var foodsCartTableView: UITableView!
 
    var cartList = [Cart]() {
        didSet{
            cartList.sort {$0.yemek_adi! < $1.yemek_adi!}
        }
    }
    
    var userName = "\((Firebase.Auth.auth().currentUser?.email)!)"
    
    var priceForPayment: Int?
    
    var foodsCartPresenterInstance: ViewToPresenterFoodsCartProtocol?
    
    var basicPrice: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodsCartTableView.delegate = self
        foodsCartTableView.dataSource = self
        
        FoodsCartRouter.createModule(ref: self)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
          
    }
    
    override func viewWillAppear(_ animated: Bool) {
            
        
        foodsCartPresenterInstance?.getFoods(kullanici_adi: userName)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCartDetail" {
            if let cart = sender as? Cart {
                let sendVC = segue.destination as! FoodDetailVC
                sendVC.cart = cart
            }
            
            if let basicPrice = basicPrice {
                let sendVC = segue.destination as! FoodDetailVC
                sendVC.basicPrice = basicPrice
            }
        }
        
        if segue.identifier == "toPayment" {
            if let price = priceForPayment {
                let sendVC = segue.destination as! PaymentVC
                sendVC.price = price
            }
        }
    }
    
    @IBAction func foodsCartOrder(_ sender: Any) {
        
        if cartList.isEmpty {
            let alert = UIAlertController(title: String(localized: "Empty_Cart"), message: String(localized: "pls_add_cart"), preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default) { action in
                self.performSegue(withIdentifier: "popToMain", sender: nil)
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: String(localized: "order_process"), message: "\(String(localized: "order_process_message")) \(self.foodsCartTotal.text!)?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: String(localized: "cancel_id"), style: .cancel)
            alert.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default) { action in
                self.priceForPayment = (self.cartList.map({Int($0.yemek_fiyat!) ?? 0}).reduce(0, +))
                self.performSegue(withIdentifier: "toPayment", sender: nil)
                self.foodsCartPresenterInstance?.deleteAll(allCart: self.cartList, kullanici_adi: self.userName)
                self.foodsCartTableView.reloadData()
                self.foodsCartTableView.dataSource = nil
                self.foodsCartTotal.text = "0 ₺"
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true)

        }
  
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        if cartList.isEmpty {
            
            let alert = UIAlertController(title: String(localized: "Empty_Cart"), message: String(localized: "empty_card_message"), preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default) { action in
                self.performSegue(withIdentifier: "popToMain", sender: nil)
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: String(localized: "delete_id_title"), message: String(localized: "delete_all_id"), preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: String(localized: "cancel_id"), style: .cancel)
            alert.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .destructive) { action in
                self.foodsCartPresenterInstance?.deleteAll(allCart: self.cartList, kullanici_adi: self.userName)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "popToMain", sender: nil)
                    self.foodsCartTableView.reloadData()
                    self.foodsCartTableView.dataSource = nil
                    self.foodsCartTotal.text = "0 ₺"
                }
                //sometimes there remains one product for sure we are doing the deleteAll process again
                if self.cartList.isEmpty == false {
                    self.foodsCartPresenterInstance?.deleteAll(allCart: self.cartList, kullanici_adi: self.userName)
                }
                DispatchQueue.main.async {
                    self.foodsCartTableView.reloadData()
                    self.foodsCartTableView.dataSource = nil
                    self.foodsCartTotal.text = "0 ₺"
                }
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }
        
    }
    
}

extension FoodCartVC: PresenterToViewFoodsCartProtocol {
    func sendDataToView(cartList: [Cart]) {
        self.cartList = cartList
        self.foodsCartTableView.reloadData()
    }
}

extension FoodCartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartList.isEmpty {
            foodsCartTableView.setEmptyMessage(String(localized: "empty_tableview"), "emptyCart")
            foodsCartTotal.text = "0 ₺"
            foodsCartOrder.tintColor = UIColor(white: 0.1, alpha: 0.3)
            foodsCartOrder.backgroundColor = UIColor(white: 0.1, alpha: 0.3)
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(white: 0.1, alpha: 0.3)
        }else{
            foodsCartTableView.restore()
            foodsCartTotal.text = "\(cartList.map({Int($0.yemek_fiyat!) ?? 0}).reduce(0, +)) ₺"
            foodsCartOrder.tintColor = UIColor.white
            foodsCartOrder.backgroundColor = UIColor(named: "colorDangerRed")
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "colorDangerRed")
        }
        
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cart = cartList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        
        cell.cartNameLabel.text = cart.yemek_adi
                
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cart.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.cartImage.kf.setImage(with: url)
            }
        }
        
            cell.cartStepper.value = Double(Int(cart.yemek_siparis_adet!)!)
            self.basicPrice = (Int(cart.yemek_fiyat!)! / Int(cart.yemek_siparis_adet!)!)
            cell.cartPriceLabel.text = "\(((Int(cart.yemek_fiyat!)! / Int(cart.yemek_siparis_adet!)!)) * Int(cart.yemek_siparis_adet!)!) ₺"
        
            cell.stepperAction = { sender in
                
                if cell.cartStepper.leftButton.isTouchInside || cell.cartStepper.rightButton.isTouchInside {
                    
                    if cell.cartStepper.value == 0 {
                             
                        let cart = self.cartList[indexPath.row]
                                        
                        let alert = UIAlertController(title: String(localized: "delete_id_title"), message: "\(String(localized: "product_delete_message")) \(cart.yemek_adi!).", preferredStyle: .alert)
                                        
                        let cancelAction = UIAlertAction(title: String(localized: "cancel_id"), style: .cancel) { action in
                            cell.cartStepper.value = 1
                        }
                        alert.addAction(cancelAction)
                                        
                        let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .destructive) { action in
                            self.cartList.remove(at: indexPath.row)
                            self.foodsCartPresenterInstance?.delete(sepet_yemek_id: Int(cart.sepet_yemek_id!)!, kullanici_adi: cart.kullanici_adi!)
                            DispatchQueue.main.async {
                                self.foodsCartTableView.reloadData()
                            }
                        }
                        alert.addAction(okAction)
                                
                        self.present(alert, animated: true)
                                                          
                    }else{
                        
                        self.foodsCartPresenterInstance?.delete(sepet_yemek_id: Int(cart.sepet_yemek_id!)!, kullanici_adi: cart.kullanici_adi!)
                        self.foodsCartPresenterInstance?.add(yemek_adi: cart.yemek_adi!, yemek_resim_adi: cart.yemek_resim_adi!, yemek_fiyat: ((Int(cart.yemek_fiyat!)! / Int(cart.yemek_siparis_adet!)!) * Int(cell.cartStepper.value)) , yemek_siparis_adet: Int(cell.cartStepper.value), kullanici_adi: cart.kullanici_adi!)
                                       
                    }
                    
                    self.foodsCartTableView.isScrollEnabled = false
                    
                    cell.isUserInteractionEnabled = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.foodsCartTableView.isScrollEnabled = true
                        cell.isUserInteractionEnabled = true
                        
                    }
                    
            }
                
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cart = cartList[indexPath.row]
        performSegue(withIdentifier: "toCartDetail", sender: cart)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: String(localized: "delete_id")) {(ca, v, b) in
            let cart = self.cartList[indexPath.row]
            
            let alert = UIAlertController(title: String(localized: "delete_id_title"), message: "\(String(localized: "product_delete_message")) \(cart.yemek_adi!).", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: String(localized: "cancel_id"), style: .cancel)
            alert.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .destructive) { action in
                self.cartList.remove(at: indexPath.row)
                self.foodsCartPresenterInstance?.delete(sepet_yemek_id: Int(cart.sepet_yemek_id!)!, kullanici_adi: cart.kullanici_adi!)
                DispatchQueue.main.async {
                    self.foodsCartTableView.reloadData()
                }
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
}


