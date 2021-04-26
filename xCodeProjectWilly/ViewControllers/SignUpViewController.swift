//
//  SignUpViewController.swift
//  xCodeProjectWilly
//
//  Created by Victor on 2020-09-18.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        //Göm felmeddelande
        errorLabel.alpha = 0
    }
    
    
    //kontrollera samtliga fält så datan är korrekt
    func validate() -> String? {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Fill in all fields"
        }
        return nil
    }
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validate()
        
        if error != nil {
            //något fel visa error
            showError(_message: error!)
            
        }
        else{
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //skapa user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    //Fel vid skapande av anändare
                    self.showError(_message: "Some error while creating user")
                }
                else{
                    //skapa user
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        
                        "firstname": firstName,
                        "lastname": lastName,
                        "uid":result!.user.uid
                        
                    ]) { (error) in
                        if error != nil {
                            self.showError(_message: "Cant save to db by some reason")
                        }
                    }
                    
                    
                    self.transitionToHome()
                    
                }
            }
            
        }
    }
    
    func showError (_message: String) {
        
        errorLabel.text = _message
        errorLabel.alpha = 1
        
    }
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
