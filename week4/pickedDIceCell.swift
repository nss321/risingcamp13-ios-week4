//
//  pickedDIceCell.swift
//  week4
//
//  Created by BAE on 2023/01/11.
//

import UIKit

class pickedDIceCell: UITableViewCell {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var first: UIImageView!
    @IBOutlet weak var second: UIImageView!
    @IBOutlet weak var third: UIImageView!
    @IBOutlet weak var fourth: UIImageView!
    @IBOutlet weak var fifth: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
