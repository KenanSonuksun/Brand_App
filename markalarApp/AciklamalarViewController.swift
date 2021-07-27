//
//  AciklamalarViewController.swift
//  markalarApp
//
//  Created by Pars arge on 12.07.2021.
//

import UIKit

class AciklamalarViewController: UIViewController {
    
    var aciklama = ""
    @IBOutlet weak var lblAciklama: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblAciklama.text = aciklama
    }
    
    func setAciklama(a : String){
        aciklama = a
        if isViewLoaded {
            lblAciklama.text = aciklama
        }
        
        
    }

    

}
