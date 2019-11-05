//
//  FullImageViewController.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController, Storyboarded {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didPressSaveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didPressCanceButton))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: Actions
    @objc func didPressCanceButton(_ button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didPressSaveButton(_ button: UIBarButtonItem) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new vifew controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
