//
//  BookCell.swift
//  readAR
//
//  Created by Michelle Duong on 4/25/24.
//

import UIKit

class BookCell: UITableViewCell {


    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
