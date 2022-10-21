//
//  DetailScreenVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 18.10.2022.
//

import UIKit

class FoodDetailVC: UIViewController {

    @IBOutlet weak var foodsDetailName: UILabel!
    @IBOutlet weak var foodsDetailPrice: UILabel!
    @IBOutlet weak var foodsDetailImage: UIImageView!
    @IBOutlet weak var foodsDetailStepper: GMStepper!
    
    var food: Foods?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func foodsDetailButton(_ sender: Any) {
    }
    
}
