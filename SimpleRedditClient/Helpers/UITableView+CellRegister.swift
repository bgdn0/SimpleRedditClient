//
//  UITableView+CellRegister.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

extension UITableView {
    func regusterRedditCell() {
        let nib = UINib(nibName: "PostTableViewCell", bundle: Bundle.main)
        self.register(nib, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
}
