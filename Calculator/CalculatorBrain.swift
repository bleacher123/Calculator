//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by teriyakibob on 2017/3/8.
//  Copyright © 2017年 hoodsound. All rights reserved.
//

import Foundation
func changeSign (operand:Double) -> Double {
    return -operand
}


struct CalculatorBrain {
    
    mutating func addUnaryOperation(named symbol:String, _ operation: @escaping (Double) -> Double) {
        operations[symbol] = Operation.unaryOperation(operation)
    }
    
    private var accumulator : Double?
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    private var operations: Dictionary<String,Operation> =
    [
    "π": Operation.constant(Double.pi),
    "e": Operation.constant(M_E),
    "√": Operation.unaryOperation(sqrt),
    "cos": Operation.unaryOperation(cos),
    "±": Operation.unaryOperation(changeSign),
    "×": Operation.binaryOperation({ (opt1:Double,opt2:Double) -> Double in
        return opt1 * opt2
        }
),
    "÷": Operation.binaryOperation({ (opt1:Double,opt2:Double) -> Double in
        return opt1 / opt2
        }
),
    "+": Operation.binaryOperation({  $0 + $1
        }
),
    "-": Operation.binaryOperation({ $0 - $1}),
    "=": Operation.equals
    
    ]
    
    mutating func perfumeOperation(_ symbol: String)  {
//        switch symbol {
//        case "π":
//            // display.text = String(Double.pi)
//            accumulator = Double.pi
//        case "√":
//            if let operand = accumulator {
//            // display.text = String( sqrt(operand!))
//            accumulator = sqrt(operand)
//            }
//        default:
//            break
//        }
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let associatedContentValue):
                accumulator = associatedContentValue
            case .unaryOperation(let function):
                if accumulator != nil {
                accumulator = function(accumulator!)
                }
            case .binaryOperation(let function) :
                if accumulator != nil {
                pendingBinaryOperation = pendingBaniaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinartOperation()
            }
        }
        
    }
    private mutating func performPendingBinartOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
        accumulator =  pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: pendingBaniaryOperation?
    private struct pendingBaniaryOperation {
        let function : (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand:Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
           return accumulator
        }
    }
    
}
