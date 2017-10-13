//
//  FirstViewController.swift
//  eduardTestProject
//
//  Created by Novikov on 13.09.17.
//  Copyright © 2017 Novikov. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class FirstViewController: UIViewController {

    //добавляем строки "name", "email", "date of birth"
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var datePickerTxt: UITextField!
 
    //добавяем date picker
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            createDatePicker()
        
       
    }
    func createDatePicker() {
        
            datePicker.datePickerMode = .date
        
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
        
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolbar.setItems([doneButton], animated: false)
        
            datePickerTxt.inputAccessoryView = toolbar
            datePickerTxt.inputView = datePicker

    }
    //нажатие кнопки "done"
    func donePressed(){
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
        
        datePickerTxt.text = dateFormatter.string(from: datePicker.date)
            self.view.endEditing(true)
    }
 
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func save(sender : UIButton) {
        if nameTextField.text!.isEmpty || emailTextField.text!.isEmpty || datePickerTxt.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "You dont compele your information", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        } else {
            let alert = UIAlertController(title: "Ok", message: "You information was saved", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
    
            let man = People()
            man.name = nameTextField.text
            man.email = emailTextField.text
            man.birthday = datePickerTxt.text
            let manager = DataCoreManger()
            
            manager.saveMan(man: man)
        }
        
    }
    
    
    

}

