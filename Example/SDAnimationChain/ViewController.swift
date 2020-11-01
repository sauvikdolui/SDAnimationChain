//
//  ViewController.swift
//  SDAnimationChain
//
//  Created by sauvikdolui on 11/01/2020.
//  Copyright (c) 2020 sauvikdolui. All rights reserved.
//

import UIKit
import SDAnimationChain

class ViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var innerBox: UIView!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var innerBoxCentreX: NSLayoutConstraint!
    @IBOutlet weak var innerBoxWidth: NSLayoutConstraint!
    
    @IBOutlet weak var labelstackView: UIStackView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var label1Width: NSLayoutConstraint!
    @IBOutlet weak var label2Width: NSLayoutConstraint!
    @IBOutlet weak var label3Width: NSLayoutConstraint!
    @IBOutlet weak var label4Width: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //container.layer.borderColor = UIColor.black.cgColor
        //container.layer.borderWidth = 1.0
        container.layer.cornerRadius = 10.0
        container.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 0)
        container.layer.shadowRadius = 10.0
        container.layer.shadowOpacity = 1.0
        
        containerHeight.constant = 20.0
        containerWidth.constant = 20.0
        
        innerBox.layer.cornerRadius = 5.0
        innerBox.backgroundColor = label1.backgroundColor
        innerBox.isHidden = true
        
        labelstackView.isHidden = true
        self.label1Width.constant = 0.0
        self.label2Width.constant = 0.0
        self.label3Width.constant = 0.0
        self.label4Width.constant = 0.0
        for view in labelstackView.subviews {
            view.layer.cornerRadius = 5.0
            view.layer.masksToBounds = true
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        containerHeight.constant = 20.0
        containerWidth.constant = 20.0
        
        innerBox.isHidden = true
        innerBox.layer.cornerRadius = 5.0
        innerBoxWidth.constant = 10.0
        innerBoxCentreX.constant = 0.0
        
        labelstackView.isHidden = true
        label1Width.constant = 0.0
        label2Width.constant = 0.0
        label3Width.constant = 0.0
        label4Width.constant = 0.0
    }
    
    @IBAction func animateButtonTapped(_ sender: UIButton) {
        view.layoutIfNeeded()
        
        UIView.Animator().springAnimate(duration: 0.5, dampingRatio: 0.7, initialVelocity: 1.0, animations: { [weak self] in
            self?.containerWidth.constant = 240.0
            self?.view.layoutIfNeeded()
        }).thenSpringAnimate(duration: 0.5, dampingRatio: 0.7, initialVelocity: 1.0, animations: { [weak self] in
            self?.containerHeight.constant = 128.0
            self?.view.layoutIfNeeded()
        }, completion: { finished in
            // completion
        }).thenTransitionWith(view: container, duration: 0.5, options: [.transitionFlipFromTop], animations: {
            // Empty completion block
        }).thenSpringAnimate(duration: 1.0, delay: 0.5, dampingRatio: 0.7, initialVelocity: 1.0, animations: { [weak self] in
            self?.innerBox.isHidden = false
            self?.innerBoxWidth.constant = 60.0
            self?.innerBoxCentreX.constant = -80.0
            self?.innerBox.layer.cornerRadius = 10.0
            self?.view.layoutIfNeeded()
        }, completion: {[weak self] _ in
            self?.labelstackView.isHidden = false
        }).thenAnimate(duration: 0.5, animations:  { [weak self] in
            guard let welf = self else { return }
            welf.label1Width.constant = welf.containerWidth.constant - welf.innerBoxWidth.constant - 36.0
            welf.view.layoutIfNeeded()
        }).thenAnimate(duration: 0.5, animations:  { [weak self] in
            guard let welf = self else { return }
            welf.label2Width.constant = welf.containerWidth.constant - welf.innerBoxWidth.constant - 36.0
            welf.view.layoutIfNeeded()
        }).thenAnimate(duration: 0.5, animations:  { [weak self] in
            guard let welf = self else { return }
            welf.label3Width.constant = welf.containerWidth.constant - welf.innerBoxWidth.constant - 36.0
            welf.view.layoutIfNeeded()
        }).thenAnimate(duration: 0.7, animations:  { [weak self] in
            guard let welf = self else { return }
            welf.label4Width.constant = welf.containerWidth.constant - welf.innerBoxWidth.constant - 100.0
            welf.view.layoutIfNeeded()
        }).start()
        
    }
}
