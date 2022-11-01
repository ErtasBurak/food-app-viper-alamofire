//
//  CartTableViewCell.swift
//  FoodApp
//
//  Created by Burak Ertaş on 21.10.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cartPriceLabel: UILabel!
    @IBOutlet weak var cartStepper: GMStepper!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartNameLabel: UILabel!
    
    var stepperAction: ((Any) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func foodsCartStepperButton(_ sender: Any) {
        
        self.stepperAction?(sender)

    }
    
}
