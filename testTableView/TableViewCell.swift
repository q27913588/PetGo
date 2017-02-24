//
//  TableViewCell.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/1/16.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Textcolor: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var doblable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
        // Configure the view for the selected state
    }


}
