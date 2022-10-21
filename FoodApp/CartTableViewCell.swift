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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
