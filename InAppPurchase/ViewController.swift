//
//  ViewController.swift
//  InAppPurchase
//
//  Created by ramil on 10.09.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapRemoveAds() {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "upgrade") else { return }
        
        vc.title = "Remove Ads"
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    


}

