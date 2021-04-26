//
//  HomeViewController.swift
//  xCodeProjectWilly
//
//  Created by Victor on 2020-09-18.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        updateVaccinated()
        super.viewDidLoad()
    }
    
    func updateVaccinated(){
        Api.getVaccinated(){vaccinatedAmount in
            print("PRINT \(vaccinatedAmount)")
            self.welcomeLabel.text = String("Antal vaccinerade i sverige: \(vaccinatedAmount)")
        }
    }
}
