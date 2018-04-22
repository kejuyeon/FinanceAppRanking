//
//  AppItemCell.swift
//  FinanceAppRanking
//
//  Created by Juyeon Kim on 2018. 4. 19..
//  Copyright © 2018년 Juyeon Kim. All rights reserved.
//

import UIKit

class AppItemCell: UITableViewCell {

    
    @IBOutlet weak var thumImage: MyImageView!
    @IBOutlet weak var rankingText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var categoryText: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
