//
//  MovieDetailTableViewCell.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/20/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var dropDownImg: UIImageView!

    @IBOutlet weak var movieOverViewDropDown: UIView!
    
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var titleOfTheMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
