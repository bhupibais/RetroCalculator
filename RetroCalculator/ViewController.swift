//
//  ViewController.swift
//  RetroCalculator
//
//  Created by BhupinderJit Bais on 2017-08-06.
//  Copyright © 2017 BhupinderJit Bais. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
         case Divide =  "/"
         case Multiply = "*"
         case Subtract = "-"
         case Add = "+"
         case Empty = "Empty"
    }
    var currentOperation = Operation.Empty
    var runningNumber = ""
    
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
           } catch let err as NSError {
              print(err.debugDescription)
             }
        
        outputLbl.text="0"
        
    }
    
    
    @IBAction func numberPressed (Sender: UIButton)
    {
        playSound()
        runningNumber += "\(Sender.tag)"
        outputLbl.text = runningNumber
        
    }
    
    func playSound()
    {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    
    @IBAction func onDividePressed (sender: Any )
    {
      processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed (sender: Any )
    {
     processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed (sender: Any )
    {
     processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed (sender: Any )
    {
     processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed (sender: Any )
    {
        processOperation(operation: currentOperation)
    }
    
  
    @IBAction func clearBtnPressed(_ sender: Any) {
        playSound()
        clearContents()
    }
    
    func clearContents () {
        
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        result = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
    }
    
    
    func processOperation (operation: Operation) {
         playSound()
        
        if currentOperation != Operation.Empty {
            //A user selcted an operator and then selected another operator without first entering a number
            if runningNumber != "" {
               rightValStr = runningNumber
               runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                     result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else  if currentOperation == Operation.Add {
                     result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
               leftValStr = result
                outputLbl.text = result
            }
            currentOperation = operation
        }
        else
        {
            //This is first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}

