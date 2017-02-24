//
//  FoloowTableViewCell.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/16.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class FoloowTableViewCell: UITableViewCell {
    @IBOutlet weak var animalIMG: UIImageView!

    @IBOutlet weak var TextName: UILabel!
    
    @IBOutlet weak var TextAge: UILabel!
    
    @IBOutlet weak var TextSex: UILabel!
    
    @IBOutlet weak var Texttime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animalIMG.contentMode = .scaleAspectFill
        animalIMG.layer.masksToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
