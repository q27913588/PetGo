//
//  TableViewCell2.swift
//  testTableView
//
//  Created by 謝樹瑄 on 2017/2/2.
//  Copyright © 2017年 謝樹瑄. All rights reserved.
//

import UIKit

class TableViewCell2: UITableViewCell {
    @IBOutlet weak var AnimalColor: UILabel!
    @IBOutlet weak var animalIMG: UIImageView!
    
    @IBOutlet weak var TextuserID: UILabel!
    
  @IBOutlet weak var AnimalName: UILabel!
    
    @IBOutlet weak var TextAge: UILabel!
    
    @IBOutlet weak var TextSex: UILabel!
   
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
