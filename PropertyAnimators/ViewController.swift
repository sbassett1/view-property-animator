//
//  ViewController.swift
//  PropertyAnimators
//
//  Created by Stephen Bassett on 5/21/19.
//  Copyright © 2019 Stephen Bassett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var block: UIView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var slider: UISlider!
    
    
    var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAnimation()
    }
    
    @IBAction func starAnimation(_ sender: Any) {
        
        if animator.isRunning {
            return
        }
        
        switch animator.state {
        case .active:
            animator.isReversed = true
            animator.addAnimations {
                self.block.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
            }
            animator.startAnimation() //continueAnimation(withTimingParameters: <#T##UITimingCurveProvider?#>, durationFactor: <#T##CGFloat#>)
        case .inactive:
            setupAnimation()
            animator.startAnimation()
        case .stopped:
            animator.finishAnimation(at: UIViewAnimatingPosition.end)
            print("we stopped")
        @unknown default:
            break
        }
    }
    
    @IBAction func pauseAnimation(_ sender: Any) {
        if animator.state == UIViewAnimatingState.active {
            animator.pauseAnimation()
            slider.value = Float(animator.fractionComplete)
        }
    }
    
    @IBAction func stopAnimation(_ sender: Any) {
        animator.stopAnimation(false)
    }
    
    @IBAction func sliderDidChange(_ sender: Any) {
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    func setupAnimation() {
        self.block.transform = CGAffineTransform.identity
        self.block.frame.origin.x = CGFloat(0)
        
        animator = UIViewPropertyAnimator(duration: 1.2, curve: UIView.AnimationCurve.linear, animations: {
            let screenWidth = self.view.frame.size.width
            let blockWidth = self.block.frame.size.width
            self.block.frame.origin.x = screenWidth - blockWidth
            
            self.block.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        })
        
        animator.addCompletion { position in
            self.block.backgroundColor = UIColor.red
        }
    }


}

