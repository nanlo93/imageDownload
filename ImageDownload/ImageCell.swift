//
//  ImageCell.swift
//  ImageDownload
//
//  Created by Shin on 2023/03/01.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var ivIphone: UIImageView!
    @IBOutlet weak var btnLoadImage: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setLayout()
    }
    
    func setLayout() {
        self.ivIphone.layer.cornerRadius = self.ivIphone.frame.height / 5
        self.btnLoadImage.layer.cornerRadius = self.btnLoadImage.frame.height / 5
        
        self.ivIphone.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
