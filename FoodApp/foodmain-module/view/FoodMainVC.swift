//
//  MainScreenVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 18.10.2022.
//

import UIKit
import Kingfisher

class FoodMainVC: UIViewController {

    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var foodsList = [Foods]()
    
    var foodsMainPresenterInstance: ViewToPresenterFoodsMainProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        
        searchBar.delegate = self
        foodTableView.delegate = self
        foodTableView.dataSource = self
        
        FoodsMainRouter.createModule(ref: self)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        foodsMainPresenterInstance?.foodsGet()
        searchBar.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let food = sender as? Foods {
                let sendVC = segue.destination as! FoodDetailVC
                sendVC.food = food
                
            }
        }
    }
    
    
    
}

extension FoodMainVC: PresenterToViewFoodsMainProtocol {
    
    func sendDataToView(foodsList: [Foods]) {
        self.foodsList = foodsList
        self.foodTableView.reloadData()
    }
    
}

extension FoodMainVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        foodsMainPresenterInstance?.search(searchWord: searchText)
    }
    
}

extension FoodMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foodsList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell") as! FoodTableViewCell
        cell.selectionStyle = .none
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImage.kf.setImage(with: url)
            }
        }
        
        cell.foodNameLabel.text = food.yemek_adi
        cell.foodPriceLabel.text = "\(food.yemek_fiyat!) ₺"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foodsList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: food)
    }
    
    
}
