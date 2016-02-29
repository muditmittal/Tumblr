//
//  LoginViewController.swift
//  Tumblr
//
//  Created by Mudit Mittal on 2/28/16.
//  Copyright © 2016 Mudit Mittal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var fadeTransition: FadeTransition!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        fadeTransition = FadeTransition()
        destinationViewController.transitioningDelegate = fadeTransition
        fadeTransition.duration = 0.6
    }

}
