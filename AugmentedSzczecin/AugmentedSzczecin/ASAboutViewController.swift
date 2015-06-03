//
//  ASAboutViewController.swift
//  AugmentedSzczecin
//
//  Created by Grzegorz Pawlowicz on 31.05.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASAboutViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var applicationNameAndVersionLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.image = UIImage(named: "szczecin_bg")
        logoImage.image = UIImage(named: "logo_as_vert")
        
        let applicationName: AnyObject? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName")
        let applicationVersion: AnyObject? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")
        let applicationBuild: AnyObject? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion")
        applicationNameAndVersionLabel.text = "\(applicationName!) \(applicationVersion!)(\(applicationBuild!))"
        applicationNameAndVersionLabel.textColor = UIColor.blackAugmentedColor()
        
        closeButton.setTitle("Close".localized, forState: UIControlState.Normal)
        closeButton.setTitleColor(UIColor.mediumBlueAugmentedColor(), forState: UIControlState.Normal)
        
        aboutTextView.textColor = UIColor.blackAugmentedColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
