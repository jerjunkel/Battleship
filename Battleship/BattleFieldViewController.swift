//
//  FirstViewController.swift
//  Battleship
//
//  Created by Jason Gresh on 9/16/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class BattleFieldViewController: UIViewController {

    let battileFieldInstance = BattleFieldEngine()
    
    @IBOutlet weak var missesLabel: UILabel!
    @IBOutlet weak var hitsLabel: UILabel!
    @IBOutlet weak var fieldView: UIView!
    @IBAction func revealButton(_ sender: UIButton) {
        print("Surrender")
        surrender()
    }
    @IBOutlet weak var targetLabel: UILabel!
    
    var misses = 0
    var hits = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        battileFieldInstance.placeShip()
        setUpGameButtons(v: fieldView, totalButtons: 100)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func disableCardButtons() {
        for v in fieldView.subviews {
            if let button = v as? UIButton {
                button.isEnabled = false
            }
        }
    }
    
    func buttonTapped(sender: UIButton){
       
        let result = battileFieldInstance.checkArray(buttonPosition: sender.tag)
    
        if result.0 {
            hits += 1
            hitsLabel.text = "Hits: " + String(hits)
            targetLabel.text = result.1 + " Hit!!"
            sender.backgroundColor = UIColor.white
            sender.setTitle("⦿", for: UIControlState())
            sender.setTitleColor(UIColor.black, for: UIControlState())
            sender.isEnabled = false
            
        }else{
            misses += 1
            missesLabel.textColor = UIColor.red
            missesLabel.text = "Miss: " + String(misses)
            sender.setTitle("☀︎", for: UIControlState())
            targetLabel.text = result.1
            sender.backgroundColor = UIColor.red
            sender.isEnabled = false

        }
        
        
        
    }
    func setUpGameButtons(v: UIView, totalButtons: Int, buttonsPerRow:Int = 10) {
        for i in 1...100 {
            let y = ((i - 1) / buttonsPerRow)
            let x = ((i - 1) % buttonsPerRow)
            let side : CGFloat = v.bounds.size.width / CGFloat(buttonsPerRow)
            
            let rect = CGRect(origin: CGPoint(x: side * CGFloat(x), y: (CGFloat(y) * side)), size: CGSize(width: side, height: side))
            let button = UIButton(frame: rect)
            button.tag = i
            button.backgroundColor = UIColor.blue
            //button.setTitle(String(i), for: UIControlState()) add numbers to buttons
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            v.addSubview(button)
            
        
        }
        
        
     
    }
    
    //
    func surrender(){
        
        for v in fieldView.subviews{
            if let button = v  as? UIButton{
                buttonTapped(sender: button)
                button.isEnabled = false
                
                
                
            }
        }
    }
        


}

