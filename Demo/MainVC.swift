//
//  MainVC.swift
//  Demo
//
//  Created by abdurrahman on 06/05/2017.
//  Copyright © 2017 Abdurrahman. All rights reserved.
//

import UIKit

class MainVC: UIViewController,UITableViewDelegate,UITableViewDataSource,BaseTVCDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayOfFeedData = [FeedCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400
        
        tableView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0)
        
        // Dummy data initialization
        let feedCardLiked = FeedCard()
        feedCardLiked.isLiked = true
        
        let feedCardUnliked = FeedCard()
        feedCardUnliked.isLiked = false
        
        let feedCardLong = FeedCard()
        feedCardLong.textCaption = "Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome. Man this is awesome."
        
        arrayOfFeedData.append(feedCardLiked)
        arrayOfFeedData.append(feedCardLong)
        arrayOfFeedData.append(feedCardUnliked)
        arrayOfFeedData.append(feedCardUnliked)
        arrayOfFeedData.append(feedCardLiked)
        arrayOfFeedData.append(feedCardUnliked)
        arrayOfFeedData.append(feedCardUnliked)
        arrayOfFeedData.append(feedCardUnliked)
        arrayOfFeedData.append(feedCardUnliked)
        arrayOfFeedData.append(feedCardUnliked)
        arrayOfFeedData.append(feedCardUnliked)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFeedData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTVC") as! FeedTVC
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.delegate = self
        cell.feedCard = arrayOfFeedData[indexPath.row]
        cell.refresh()
        return cell
    }
    
    func triggerAction(baseVC: BaseTVC, actionName: String, info: AnyObject?) {
        if actionName == "showToast" {
            self.showToast(message: info as! String)
        }
    }

}
