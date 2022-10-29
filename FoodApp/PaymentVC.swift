//
//  PaymentVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 28.10.2022.
//

import UIKit
import UserNotifications

class PaymentVC: UIViewController {

    var price: Int?
    
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tfNameSurname: UITextField!
    @IBOutlet weak var tfCardNumber: UITextField!
    @IBOutlet weak var tfCVV: UITextField!
    @IBOutlet weak var tfaddress1: UITextField!
    @IBOutlet weak var tfAddress2: UITextField!
    @IBOutlet weak var tftime: UITextField!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var nowButton: UIButton!
    
    var datePicker: UIDatePicker?
    
    var timePicker: UIDatePicker?
    
    var permissionControl = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)

        priceLabel.text = "\(price!) ₺"
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            self.permissionControl = granted
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        tfCVV.delegate = self
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        tfDate.inputView = datePicker
        
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        tftime.inputView = timePicker
        
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
            timePicker?.preferredDatePickerStyle = .wheels
        }
        
        datePicker?.addTarget(self, action: #selector(showDate(uiDatePicker:)), for: .valueChanged)
        
        timePicker?.addTarget(self, action: #selector(showTime(uiDatePicker:)), for: .valueChanged)
        
        segControl.addTarget(self, action: #selector(segmentedControlTap), for: .valueChanged)
        
        nowButton.addTarget(self, action: #selector(nowButtonTap), for: .touchUpInside)
         
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(tapRecMethod))
        view.addGestureRecognizer(gestureRec)
        
    }
    
    @objc func nowButtonTap() {
        tftime.text = ""
        nowButton.backgroundColor = UIColor(named: "colorDangerRed")
        nowButton.tintColor = UIColor.white
    }
    
    @objc func segmentedControlTap() {
        if segControl.selectedSegmentIndex == 0 {
            tfCVV.isEnabled = true
            tfNameSurname.isEnabled = true
            tfCardNumber.isEnabled = true
            tfDate.isEnabled = true
        }else{
            tfCVV.isEnabled = false
            tfNameSurname.isEnabled = false
            tfCardNumber.isEnabled = false
            tfDate.isEnabled = false
            tfCVV.text = ""
            tfNameSurname.text = ""
            tfCardNumber.text = ""
            tfDate.text = ""
        }
    }
    
    @objc func tapRecMethod() {
        view.endEditing(true)
    }
    
    @objc func showDate(uiDatePicker: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "MM/yy"
        let pickDate = format.string(from: uiDatePicker.date)
        tfDate.text = pickDate
    }
    
    @objc func showTime(uiDatePicker: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let pickTime = format.string(from: uiDatePicker.date)
        tftime.text = pickTime
        if tftime.text == nil {
            nowButton.backgroundColor = UIColor(named: "colorDangerRed")
            nowButton.tintColor = UIColor.white
        }else{
            nowButton.backgroundColor = UIColor(white: 0.1, alpha: 0.3)
            nowButton.tintColor = UIColor.blue
            
        }
    }
    
    @IBAction func payButton(_ sender: Any) {
        if segControl.selectedSegmentIndex == 0 {
            if tfCVV.text == "" && tfCardNumber.text == "" && tfDate.text == "" && tfNameSurname.text == "" && tfaddress1.text == "" {
                
                let alert = UIAlertController(title: String(localized: "warning_payment_title"), message: String(localized: "warning_payment_message"), preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default)
                alert.addAction(okAction)
                
                self.present(alert, animated: true)
                
            } else {
                
                let alert = UIAlertController(title: String(localized: "payment_process"), message: "\(String(localized: "payment_message")) \(self.priceLabel.text!).", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: String(localized: "cancel_id"), style: .cancel)
                alert.addAction(cancelAction)
                
                let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default) { action in
                    self.performSegue(withIdentifier: "payTapped", sender: nil)
                    self.performSegue(withIdentifier: "payToMain", sender: nil)
                    self.buttonUserNotification()
                }
                alert.addAction(okAction)
                
                self.present(alert, animated: true)
                
            }
        } else {
            if tfaddress1.text == "" {
                
                let alert = UIAlertController(title: String(localized: "warning_payment_title"), message: String(localized: "warning_payment_message_credit"), preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default)
                alert.addAction(okAction)
                
                self.present(alert, animated: true)
                
            } else {
                
                let alert = UIAlertController(title: String(localized: "payment_process"), message: "\(String(localized: "payment_message")) \(self.priceLabel.text!).", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: String(localized: "cancel_id"), style: .cancel)
                alert.addAction(cancelAction)
                
                let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .default) { action in
                    self.performSegue(withIdentifier: "payTapped", sender: nil)
                    self.performSegue(withIdentifier: "payToMain", sender: nil)
                    self.buttonUserNotification()
                }
                alert.addAction(okAction)
                
                self.present(alert, animated: true)
                
            }
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        let alert = UIAlertController(title: String(localized: "cancel_process"), message: String(localized: "cancel_message") , preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: String(localized: "cancel_id"), style: .cancel)
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: String(localized: "ok_id"), style: .destructive) { action in
            self.performSegue(withIdentifier: "payToMain", sender: nil)
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
    func buttonUserNotification() {
        if permissionControl {
            let content = UNMutableNotificationContent()
            content.title = String(localized: "content_title")
            content.subtitle = String(localized: "content_subtitle")
            content.badge = 0
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let notificationRequest = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(notificationRequest)
        }
    }

}

extension PaymentVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}

extension PaymentVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 3
        let currentString = (tfCVV.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        let allowedCharacters = CharacterSet(charactersIn: "0,1,2,3,4,5,6,7,8,9").inverted

        let components = string.components(separatedBy: allowedCharacters)
        let filtered = components.joined(separator: "")
            
            if string == filtered {
                
                return true && newString.count <= maxLength

            } else {
                
                return false
            }
    }
}
