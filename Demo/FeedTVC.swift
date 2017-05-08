//
//  FeedTVC.swift
//  Demo
//
//  Created by abdurrahman on 07/05/2017.
//  Copyright © 2017 Abdurrahman. All rights reserved.
//

import UIKit

class FeedTVC: BaseTVC {

    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var labelCaption: UILabel!
    
    var feedCard = FeedCard()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    func refresh() {
        if feedCard.isLiked {
            setLiked()
        } else {
            setUnliked()
        }
        labelCaption.text = feedCard.textCaption
        
        
    }
    
    func setLiked() {
        feedCard.isLiked = true
        buttonLike.setImage(UIImage(named:"liked"), for: .normal)
        activityIndicator.removeFromSuperview()
    }
    
    func setUnliked() {
        feedCard.isLiked = false
        buttonLike.setImage(UIImage(named:"like"), for: .normal)
        activityIndicator.removeFromSuperview()
    }
    
    func showActivityIndicator() {
        buttonLike.setImage(nil, for: .normal)
        buttonLike.addSubview(activityIndicator)
        activityIndicator.frame = buttonLike.bounds
        activityIndicator.startAnimating()
    }
    
    func likeArticle(articleId:String) {
        showActivityIndicator()
        ServiceConnector.jsonREST(method: .get, url: "https://api.wormapp.co/public/api/video/\(articleId)/like", parameters: [:], headers: [:], success: { (responseDict) in
            self.setLiked()
        }) { (responseDict) in
            self.setUnliked()
            self.delegate?.triggerAction(baseVC: self, actionName: "showToast", info: "Connection error :(" as AnyObject?)
        }
    }
    
    func unlikeArticle(articleId:String) {
        showActivityIndicator()
        ServiceConnector.jsonREST(method: .get, url: "https://api.wormapp.co/public/api/video/\(articleId)/unlike", parameters: [:], headers: [:], success: { (responseDict) in
            self.setUnliked()
        }) { (responseDict) in
            self.setLiked()
            self.delegate?.triggerAction(baseVC: self, actionName: "showToast", info: "Connection error :(" as AnyObject?)
        }
    }
    
    @IBAction func buttonActionLike(_ sender: Any) {
        if feedCard.isLiked {
            unlikeArticle(articleId: "12345")
        } else {
            likeArticle(articleId: "12345")
        }
    }

}
