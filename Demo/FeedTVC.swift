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
    }
    
    func setUnliked() {
        feedCard.isLiked = false
        buttonLike.setImage(UIImage(named:"like"), for: .normal)
    }
    
    func likeArticle(articleId:String) {
        ServiceConnector.jsonREST(method: .get, url: "https://api.wormapp.co/public/api/video/\(articleId)/like", parameters: [:], headers: [:], success: { (responseDict) in
            self.setLiked()
        }) { (responseDict) in
            self.delegate?.triggerAction(baseVC: self, actionName: "showToast", info: "Connection error :(" as AnyObject?)
        }
    }
    
    func unlikeArticle(articleId:String) {
        ServiceConnector.jsonREST(method: .get, url: "https://api.wormapp.co/public/api/video/\(articleId)/unlike", parameters: [:], headers: [:], success: { (responseDict) in
            self.setUnliked()
        }) { (responseDict) in
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
