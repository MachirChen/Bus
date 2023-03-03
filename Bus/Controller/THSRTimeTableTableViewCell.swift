//
//  THSRTimeTableTableViewCell.swift
//  Bus
//
//  Created by Machir on 2023/2/27.
//

import UIKit

class THSRTimeTableTableViewCell: UITableViewCell {

    @IBOutlet weak var trainNoLabel: UILabel!
    @IBOutlet weak var totalStoppingStationsLabel: UILabel!
    @IBOutlet weak var journeyTimeLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
