//
//  RegisterVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 27.10.2022.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    

    @IBAction func buttonRegister(_ sender: Any) {
        if tfPassword.text == "" && tfPassword.text == "" {
            
            let alert = UIAlertController(title: String(localized: "warning_payment_title"), message: String(localized: "warning_payment_message"), preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default)
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }
        
    }
    

}
