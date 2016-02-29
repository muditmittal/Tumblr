//
//  TabBarViewController.swift
//  Tumblr
//
//  Created by Mudit Mittal on 2/27/16.
//  Copyright © 2016 Mudit Mittal. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    var homeViewController: UIViewController!
    var searchViewController: UIViewController!
    var accountViewController: UIViewController!
    var trendingViewController: UIViewController!

    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0

    @IBOutlet weak var popupImage: UIImageView!
    var dismisspopup = 0;
    
    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as UIViewController
        searchViewController = storyboard.instantiateViewControllerWithIdentifier("SearchViewController") as UIViewController
        accountViewController = storyboard.instantiateViewControllerWithIdentifier("AccountViewController") as UIViewController
        trendingViewController = storyboard.instantiateViewControllerWithIdentifier("TrendingViewController") as UIViewController

        viewControllers = [homeViewController, searchViewController, accountViewController, trendingViewController]

        buttons[selectedIndex].selected = true
        didPressTab(buttons[selectedIndex])
        popupImage.layer.zPosition = 1;
        animate()
    }
    
    @IBAction func didPressTab(sender: UIButton) {
        //Initialize index
        let previousIndex = selectedIndex
        selectedIndex = sender.tag

        if selectedIndex == 1 {
            dismisspopup = 1
        }
        
        //Remove previous view
        buttons[previousIndex].selected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMoveToParentViewController(nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        //Enable current view
        sender.selected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)

        vc.view.alpha = 0
        UIView.animateWithDuration(0.3, animations: {
            vc.view.alpha = 1
            }) {(Bool) -> Void in
                vc.didMoveToParentViewController(self)}
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        fadeTransition = FadeTransition()
        destinationViewController.transitioningDelegate = fadeTransition
        fadeTransition.duration = 0.6
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animate() {
        if (dismisspopup == 0) {
            let originalx = CGFloat(0)
            let originaly = CGFloat(0)
            
            popupImage.transform = CGAffineTransformMakeTranslation(originalx, originaly)
            UIView.animateWithDuration(0.4, delay: 0.1, options: [], animations: {
                self.popupImage.transform = CGAffineTransformMakeTranslation(originalx, originaly - 10)
                }, completion: { (Bool) -> Void in
                    UIView.animateWithDuration(0.4, delay: 0.1, options: [], animations: {
                        self.popupImage.transform = CGAffineTransformMakeTranslation(originalx, originaly)
                        }, completion: { (Bool) -> Void in
                            self.animate()
                    })
            })
        } else if (dismisspopup == 1) {
            UIView.animateWithDuration(0.3, delay: 0, options: [], animations: {
                self.popupImage.alpha = 0
                }, completion: nil)
        }

        
    }



}


