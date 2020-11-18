//
//  CardStatTableViewCell.swift
//  E-Covid Data
//
//  Created by Randy Efan Jayaputra on 17/11/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import UIKit

class CardStatTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cardImageProv: UIImageView!
    @IBOutlet weak var cardLabelProv: UILabel!
    @IBOutlet weak var cardPositiveLabel: UILabel!
    @IBOutlet weak var cardPositiveCountLabel: UILabel!
    @IBOutlet weak var cardRecoverLabel: UILabel!
    @IBOutlet weak var cardRecoverCountLabel: UILabel!
    @IBOutlet weak var cardDeathLabel: UILabel!
    @IBOutlet weak var cardDeathCountLabel: UILabel!
    @IBOutlet weak var cardView: UIView!{
        didSet {
            cardView.layer.cornerRadius = 20
        }
    }
    
    func setupCell(viewModel: StatsByProvinceModel) {
        super.layoutSubviews()
        self.cardImageProv.image = UIImage(named: "\(viewModel.daerah)")
        self.cardLabelProv.text = viewModel.daerah
        self.cardPositiveLabel.text = "+\(viewModel.penambahanPositif.formattedWithSeparator)"
        self.cardPositiveCountLabel.text = "\(viewModel.jumlahKasus.formattedWithSeparator)"
        self.cardRecoverLabel.text = "+\(viewModel.penambahanSembuh.formattedWithSeparator)"
        self.cardRecoverCountLabel.text = "\(viewModel.jumlahSembuh.formattedWithSeparator)"
        self.cardDeathLabel.text = "+\(viewModel.penambahanMeninggal.formattedWithSeparator)"
        self.cardDeathCountLabel.text = "\(viewModel.jumlahMeninggal.formattedWithSeparator)"
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()

        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
