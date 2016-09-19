//
//  BattleFieldEngine.swift
//  Battleship
//
//  Created by Jermaine Kelly on 9/17/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class BattleFieldEngine{
    
    private enum Status{
        case empty
        case carrier
        case battleship
        case destroyer
        case cruiser
        case submarine
        
    }
    
    
    // private var fieldArray = [[Int]()]
   // private let test = [true,false]
    private var fieldArray = Array(repeating: Array(repeating: 0, count: 10), count:10)
    private let shipSize = [5,4,3,3,2]
    private var shipRef = 0
    
    
    
    
    
    //random generator function
    private func randomNumGenerator() -> (Int,Int){
        
        let a = Int(arc4random_uniform(UInt32(10)))
        let i = Int(arc4random_uniform(UInt32(10)))
        
        return (row: i, col:a)
        
    }
    
    //finds random position in array
    func placeShip(){
        
        while shipRef < shipSize.count {
            let pos = randomNumGenerator()
            
            if fieldArray[pos.0][pos.1] == 0{
                shipBuilder(position: pos, sizeIndex: shipRef)
                shipRef += 1
            }else{
                
                placeShip()
            }
        }
        
        //    dump(fieldArray)
    }
    
    
    //checks area for space to build ships
    private func checkArea(row: Int, col: Int, spaceNeeded:Int) -> String{
        
        var rowCount = 0
        var colCount = 0
        
        
        if spaceNeeded <= (10 - row){
            for i in 0..<spaceNeeded{
                if fieldArray[row + i][col] == 0{
                    rowCount += 1
                }
            }
        }
        
        
        
        if spaceNeeded <= (10 - col){
            for i in 0..<spaceNeeded{
                if fieldArray[row][col + i] == 0{
                    colCount += 1
                }
            }
        }
        
        
        
        if rowCount == spaceNeeded{
            return "Row"
            
        }else if colCount == spaceNeeded {
            return "Column"
        }else{
            placeShip()
        }
        
        return ""
        
    }
    
    
    private func shipBuilder(position: (Int,Int),sizeIndex:Int){
        
        let size = shipSize[sizeIndex]
        
        switch checkArea(row: position.0, col: position.1,spaceNeeded: size ){
        case "Row":
            for i in 0..<size{fieldArray[position.0 + i][position.1] = size}
        case "Column":
            for i in 0..<size{fieldArray[position.0][position.1 + i] = size}
        default:
            break
            
            
        }
        
    }
    
    
    
    //finds corresponding array position with button tag
    func checkArray(buttonPosition: Int)-> (Bool,String){
        printArray(intArray: fieldArray)
        
        var a = 0
        var i = 0
        
        a = buttonPosition / 10
        i = (buttonPosition % 10) - 1
        
        if a == 10{a = 9}
        
        if i == -1{
            i = 9; a = a - 1
        }
        
        
        let switchValue = fieldArray[a][i]
        
        switch switchValue{
        case 5:
            return (true,"Carrier")
        case 4:
            return (true,"BattleShip")
        case 3:
            return (true, "Submarine")
        case 2:
            return (true, "Destroyer")
        default:
            return (false, "Splash!")
            
            
        }
        
        //        if fieldArray[a][i] != 0{
        //            print("Ship found at", buttonPosition)
        //            return true
        //        }else{
        //            print("No ship found at", buttonPosition)
        //            return false
        //
        //        }
    }
    
    //prints array
    func printArray(intArray:[[Int]]){
        
        for (count,i) in intArray.enumerated(){
            print("row \(count): ",terminator: "")
            for a in i{
                
                print(a,terminator:"")
            }
            print("")
        }
    }
    
    
    func revealShips() -> Bool{
        
        for array in fieldArray{
            for element in array{
                
                if element != 0{
                    return true
                }else{
                    return false
                }
            }
        }
        
        return false
        
    }
    
    
    
}
