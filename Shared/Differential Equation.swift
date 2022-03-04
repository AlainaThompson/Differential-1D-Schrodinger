//
//  Differential Equation.swift
//  Differential 1D Schrodinger
//
//  Created by Alaina Thompson on 2/18/22.
//

import SwiftUI
import Darwin


class DiffEq: NSObject,ObservableObject {

    var e = Darwin.M_E
    // hbar and m are in eV
    var hbar = Double(pow(200.0, 6))
    var m = 0.510998950
    var i = sqrt(-1.0)
    // h = step size
    var h = 0.1
    var U = 0.0
    var E = 0.0
    var l = 0.0
    var k = 0.0
    var x_i = 0.0
    var x_0 = 0.0
    var psi_i = 0.0
    var psi_prime = 0.0
    var L = 2.0
    var n = 0.0
    var iterations = 0.0
    var f2 = 0.0
    var f1 = 0.0
    var fn = 0.0
    
    var xPoint = 0.0
    var psiPoint = 0.0
    var psi_num = 0.0
    
    var x_array = [Double]()
    var psi_array = [Double]()
    var psi_prime_array = [Double]()
    @Published var psi_String = ""
    
    
    
    
    @Published var enableButton = true


    func initWithDiff() async -> Bool {
               
             
                   let _ = await withTaskGroup(of:  Void.self) { taskGroup in
                       
               
                   
                       taskGroup.addTask { let _ = await self.calculateRK4()}
                   
               }
                   
                   await setButtonEnable(state: true)
                                                        
              
               

               return true
               
           }



    func calculateRK4() async -> Double {
        
        
        
// 1D Differential Time-Independent Schrodinger Equation:
//
//      2            2
//     ħ    partial Ψ(x, t)
// - -----  -----------------  +  U(x)Ψ(x, t)  = E(x)Ψ(x, t)
//    2m                2
//             partial x
//
//
//                    partial Ψ
//                             i
//  Ψ       =  Ψ   +  h * ----------
//   i + 1       i      partial x
//                               i
//
//
//
//
// Runge Kutta 4:
//
// psi_i+1 = psi_i + h*psi_i'
//
// psi(0) = 0
// psi_1 = h*psi'
// psi_0' = guess (random number )
//
//
// y_prime = f(x, Ψ)
//
// y(x_0) = initialCondition
//
// Ψ_i = Ψ_0 + i*h
//
//
//
// k1 = h*f(x_i, psi_i)
//
// k2 = f(x_i + h/2, w_i + h*k1/2)
//
// k3 = f(x_i + h/2, w_i + h*k2/2)
//
// k4 = f(x_i + h, w_i + h*k3)
//
// k + 1 = k + 1/6(k1 + 2*k2 + 2*k3 + k4)
//
//l + 1 = l + 1/6(l1 + 2*l2 + 2*l3 + l4)
    
        U = 10.0
        E = 1.123
        
        let f_num = (U-E)*2*m
        
        var f2 = (f_num/(pow(hbar, 2)))*psi_i
        
        var f1 = psi_prime
        var fn = ((U-E)*2*m)/(pow(hbar, 2))

        
        var k1 = 0.0
        var k2 = 0.0
        var k3 = 0.0
        var k4 = 0.0
        var l1 = 0.0
        var l2 = 0.0
        var l3 = 0.0
        var l4 = 0.0
        
        psi_prime = Double.random(in: 0.0...1000.0)
        l = psi_prime
        k = psi_i
        
        while n < L {
            
           
          
            
            
        
            
            f1 = psi_prime
            f2 = (f_num/(pow(hbar, 2)))*psi_i
            k1 = f1
            l1 = f2
            
            x_i = h*(x_i + h/2.0)
            psi_i = h*(k + k1/2.0)
            psi_prime = psi_prime + l1/2
            f1 = psi_prime
            f2 = (f_num/(pow(hbar, 2)))*psi_i
            k2 = f1
            l2 = f2
            
            x_i = h*(x_i + h)
            psi_i = h*(k + k2/2.0)
            psi_prime = psi_prime + l2/2
            f1 = psi_prime
            f2 = (f_num/(pow(hbar, 2)))*psi_i
            k3 = f1
            l3 = f2
            
            x_i = h*(x_i + h)
            psi_i = h*(k + k3)
            psi_prime = psi_prime + l3/2
            f1 = psi_prime
            f2 = (f_num/(pow(hbar, 2)))*psi_i
            k4 = f1
            l4 = f2
            
            x_i = x_i + iterations*h
            k = k + (k1 + 2*k2 + 2*k3 + k4)/6
            l = l + (l1 + 2*l2 + 2*l3 + l4)/6
            psi_i = k
            psi_prime = l
// k should be close to psi_i
// l should be close to psi_prime
            
            x_array.append(x_i)
            psi_array.append(k)
            psi_prime_array.append(l)
       
            
            iterations += 1.0
            
            x_i = x_i + h
            n += h
            
            
        }
        psi_i += k
        let psi_num = psi_i
        print("psi array:", psi_array)
        await updatePsiString(text: "\(psi_num)")
        return psi_i
        
    }



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
      @MainActor func updatePsiString(text:String){
          
          self.psi_String = text
          
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
