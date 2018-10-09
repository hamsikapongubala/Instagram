//
//  PostCell.swift
//  myInsta
//
//  Created by Hamsika Pongubala on 10/8/18.
//  Copyright © 2018 Hamsika Pongubala. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var imagePreview: UIImageView!
    
    @IBOutlet weak var captionField: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
