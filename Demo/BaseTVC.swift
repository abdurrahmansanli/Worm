//
//  BaseTVC.swift
//  Demo
//
//  Created by abdurrahman on 07/05/2017.
//  Copyright © 2017 Abdurrahman. All rights reserved.
//

import UIKit

protocol BaseTVCDelegate: class {
    
    func triggerAction(baseVC:BaseTVC,actionName:String,info:AnyObject?)
    
}

class BaseTVC: UITableViewCell {

    weak var delegate:BaseTVCDelegate?
    
    func triggerAction(baseVC:BaseTVC,actionName:String,info:AnyObject?) {}
    
}
