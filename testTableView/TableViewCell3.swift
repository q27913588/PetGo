//
//  TableViewCell3.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/12.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class TableViewCell3: UITableViewCell {

    @IBOutlet weak var Texttype: UILabel!
    
    @IBOutlet weak var Textname: UILabel!
    
    @IBOutlet weak var TextTime: UILabel!
    
    @IBOutlet weak var TextInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
