//
//  ValueViewController.swift
//  CoreDataDemo
//
//  Created by apple on 02/11/21.
//

import UIKit

protocol getValue {
    func getValue(name: String, email: String ,password: String, ifComingScreen: String)
}

class ValueViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var superView: UIView!
    
    
    //MARK:- Define Variable
    var getvalueDelegate: getValue!
    var ifComingScreen = ""
    var name = ""
    var email = ""
    var password = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        animateView()
        if ifComingScreen == "Edit Screen"{
            nameTextField.text = name
            emailTextField.text = email
            passwordTextField.text = password
        }
        else {
            nameTextField.text = ""
            emailTextField.text = ""
            passwordTextField.text = ""
        }
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- SetUp UI
    func SetupUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        superView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
    }
    
    //MARK:- Showing alert with Animation
    func animateView() {
        superView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.superView.transform = .identity
        }, completion: {(finished: Bool) -> Void in
            // do something once the animation finishes, put it here
        })
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        if ifComingScreen == "Edit Screen"{
            getvalueDelegate.getValue(name: nameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", ifComingScreen: "Edit Screen")
        }
        else {
            getvalueDelegate.getValue(name: nameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", ifComingScreen: "")
        }
        self.dismiss(animated: true, completion: nil)
       
    }
    
}
