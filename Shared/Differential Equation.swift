//
//  Differential Equation.swift
//  Differential 1D Schrodinger
//
//  Created by Alaina Thompson on 2/18/22.
//

import SwiftUI

class DiffEq: NSObject,ObservableObject {

    var hbar = Double(pow(1.054571817, -34))
    var m = 0.0
    var psi = 0.0
    var i = sqrt(-1.0)
    var U = 0.0
    @Published var enableButton = true


    func initWithDiff() async -> Bool {
               
             
                   let _ = await withTaskGroup(of:  Void.self) { taskGroup in
                       
               
                   
                       taskGroup.addTask { let _ = await self.calculateDiff()}
                   
               }
                   
                   await setButtonEnable(state: true)
                                                        
              
               

               return true
               
           }



    func calculateDiff() async -> Double {
// 1D Differential Schrodinger Equation:
//
//      2            2
//     ħ    partial Ψ(x, t)                         partial Ψ(x, t)
// - -----  -----------------  +  U(x)Ψ(x, t)  =   iħ -------------
//    2m                2                            partial t
//             partial x
//
//
//
//  psi function solution:
//
//                      (ikx  -  iwt)
//        Ψ(x, t)  =  A e
//
//
        
        
        
    }



    
    
    
    
    
    @MainActor func setButtonEnable(state: Bool){
        
        
        if state {
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = true
                }
            }
            
            
                
        }
        else{
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = false
                }
            }
                
        }
        
    }


    

    
    
}
