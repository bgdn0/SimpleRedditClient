//
//  PostTableViewCell.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "ReditPostCellIdentifier"
    let thumbnailDefaultWidth: CGFloat = 78.0
    let titleDefaultLeft: CGFloat = 10.0
    
    @IBOutlet weak var subredditLabel: UILabel?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var thumbnailView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var commentsLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var votesLabel: UILabel?
    
    @IBOutlet weak var thumbnailWidthContraint: NSLayoutConstraint?
    @IBOutlet weak var titleLeftContraint: NSLayoutConstraint?
    
    var thumbnail: UIImage? {
        didSet {
            let hideImage = thumbnail == nil
            thumbnailWidthContraint?.constant = hideImage ? 0 : thumbnailDefaultWidth
            titleLeftContraint?.constant = hideImage ? 0 : titleDefaultLeft
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGetsture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        thumbnailView?.addGestureRecognizer(tapGetsture)
        thumbnailView?.isUserInteractionEnabled = true
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.textLabel?.text = nil
        
        thumbnailWidthContraint?.constant = thumbnailDefaultWidth
        titleLeftContraint?.constant = titleDefaultLeft
    }
    
    
    // MARK: - Gestures
    @objc func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        print("IMG tag")
    }
}
