//
//  RegisterVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 27.10.2022.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        

    }
    

    @IBAction func buttonRegister(_ sender: Any) {
        if (tfPassword.text != "" && tfUserName.text != "") {
            
            warningLabel.text = ""
            let email = tfUserName.text!
            let password = tfPassword.text!
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if(error != nil) {
                    self.warningLabel.text = String(localized: "error_id_register")
                    print("error")
                    return
                }
                self.warningLabel.text = String(localized: "created_auth")
                
                self.performSegue(withIdentifier: "registerToMain", sender: nil)
            }
            
            
            
        } else {
            let alert = UIAlertController(title: String(localized: "warning_payment_title"), message: String(localized: "warning_payment_message"), preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default)
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }
        
        
        
    }

}
