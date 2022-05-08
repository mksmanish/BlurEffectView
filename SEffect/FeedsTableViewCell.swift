//
//  FeedsTableViewCell.swift
//  SEffect
//
//  Created by Tradesocio on 08/05/22.
//

import UIKit
import Kingfisher

class FeedsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageController: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.alpha = 0
        imageController.startShimmering()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imgView.alpha = 0
        imageController.startShimmering()
    }
    
    func fadeIn(_ url: String?) {
        
        
        //imgView.image = image
        let urlm = URL(string: url ?? "")
        self.imgView.kf.setImage(with: urlm)
        
        UIView.animate(
            withDuration: 0.35,
            delay: 1.25,
            options: [],
            animations: {
                self.imgView.alpha = 1
            }, completion: { completed in
                if completed {
                    self.imageController.stopShimmering()
                }
            })
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

private extension UIView {
    private var shimmerAnimationKey: String {
        return "shimmer"
    }
    func startShimmering() {
        let white = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.7).cgColor
        let width = bounds.width
        let height = bounds.height
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, white, alpha]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradient.locations = [0.4, 0.5, 0.6]
        gradient.frame = CGRect(x: -width, y: 0, width: width*3, height: height)
        layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: shimmerAnimationKey)
    }
    
    func stopShimmering() {
        layer.mask = nil
    }
    
}
extension FeedsTableViewCell {
    
    func configure(with model:Meme) {
        self.lblDetails.text = model.name
        self.imgView.contentMode = .scaleToFill
        self.imgView.layer.cornerRadius = 10.0
        self.fadeIn(model.url)
    }
    
}

