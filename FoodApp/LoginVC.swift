//
//  LoginVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 27.10.2022.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    @IBAction func buttonLogin(_ sender: Any) {
        if (tfPassword.text != "" && tfUserName.text != "") {
            
            warningLabel.text = ""
            let email = tfUserName.text!
            let password = tfPassword.text!
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                if(error != nil) {
                    strongSelf.warningLabel.text = String(localized: "error_id_login")
                    print("error")
                    return
                }
                strongSelf.warningLabel.text = String(localized: "login_success")
                self!.performSegue(withIdentifier: "loginToMain", sender: nil)
                
            }
            
            
            
        } else {
            let alert = UIAlertController(title: String(localized: "warning_payment_title"), message: String(localized: "warning_payment_message"), preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default)
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }
        
        
    }
    

}
