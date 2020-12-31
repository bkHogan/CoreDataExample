//
//  NoteTableViewCell.swift
//  CoreData2
//
//  Created by Field Employee on 12/30/20.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var celTopLabel: UILabel!
    @IBOutlet weak var cellContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        celTopLabel.numberOfLines = 1
        cellContentLabel.numberOfLines = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
