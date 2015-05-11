//
//  ASPointDetailViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 10.05.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASPointDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var opinionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var detailInfoHolder: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImage]()
    let POI: ASPOI!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height

        self.nameLabel.text = POI.name
        
        for index in 0...images.count {
           var img = UIImageView(frame: CGRectMake(scrollViewWidth * CGFloat(index), 0, scrollViewWidth, scrollViewWidth))
            img.image = images[index]
            self.scrollView.addSubview(img)
        }
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * CGFloat(images.count), self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView){

        var pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        var currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1

        self.pageControl.currentPage = Int(currentPage);

    }
}