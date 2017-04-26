//
//  ViewController.swift
//  Calculator
//
//  Created by teriyakibob on 2017/3/6.
//  Copyright © 2017年 hoodsound. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping: Bool = false
    
    
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
        let textCurrentlyDisplay = display.text!
        display!.text = textCurrentlyDisplay + digit
       //print("\(digit) was touched")
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
           display.text = String(newValue)
        }
    }
    private var brain = CalculatorBrain()
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false

        }
        if  let mathematicSymbol = sender.currentTitle {
        brain.perfumeOperation(mathematicSymbol)
            
        }
        if let result = brain.result {
            displayValue = result
        }
        
    }
    
    private func showSizeClasses() {
        if !userIsInTheMiddleOfTyping {
        display.textAlignment = .center
            display.text = "width " + traitCollection.horizontalSizeClass.description + " height " + traitCollection.verticalSizeClass.description
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showSizeClasses()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { coordinator in
            self.showSizeClasses()
        }, completion: nil)
    }
    
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
            brain.addUnaryOperation(named: "✅") { [weak weakSelf = self ] in
                weakSelf?.display.textColor = UIColor.green
               return sqrt($0)
            }
        // Do any additional setup after loading the view, typically from a nib.
         
          
            let effect = UIBlurEffect(style: .light)
            let effectView = UIVisualEffectView(effect: effect)
            effectView.frame = view.frame
            imgBG.addSubview(effectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    }


extension UIUserInterfaceSizeClass: CustomStringConvertible {
    public var description:String {
        switch self {
        case .compact:
            return "Compact"
        case .regular:
            return "Regular"
        case .unspecified:
            return "??"
        }
   }
}

