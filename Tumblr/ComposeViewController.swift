//
//  ComposeViewController.swift
//  Tumblr
//
//  Created by Mudit Mittal on 2/27/16.
//  Copyright © 2016 Mudit Mittal. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var quoteButton: UIButton!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    var buttons: [UIButton]!
    var originalposition: [CGFloat]!
    var movement: [CGFloat]!
    var duration: [Double]!

    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [textButton, photoButton, quoteButton, linkButton, chatButton, videoButton]
        originalposition = [textButton.frame.origin.y, photoButton.frame.origin.y, quoteButton.frame.origin.y, linkButton.frame.origin.y, chatButton.frame.origin.y, videoButton.frame.origin.y]
        movement = [600, 800, 1000, 1000, 1200, 1400]
        duration = [0.3, 0.4, 0.5, 0.5, 0.6, 0.7]
   }

    override func viewWillAppear(animated: Bool) {
        for index in 0...5 {
            buttons[index].frame.origin.y += CGFloat(movement[index])
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        for index in 0...5 {
            UIView.animateWithDuration(duration[index], animations: {
                self.buttons[index].frame.origin.y = CGFloat(self.originalposition[index])
            })
        }
    }

    @IBAction func onClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        fadeTransition = FadeTransition()
        destinationViewController.transitioningDelegate = fadeTransition
        fadeTransition.duration = 0.6
    }
    
}
