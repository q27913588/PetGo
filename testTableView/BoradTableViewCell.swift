//
//  BoradTableViewCell.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/13.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class BoradTableViewCell: UITableViewCell {
    @IBOutlet weak var TextDetail: UITextView!
    
    @IBOutlet weak var TextTime: UILabel!

    @IBOutlet weak var TextName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
