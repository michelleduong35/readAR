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
        // Initialization code
        bookImageView.layer.cornerRadius = 18
        bookImageView.layer.borderWidth = 2
        bookImageView.layer.borderColor = UIColor.white.cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
