//
//  ContentView.swift
//  Shared
//
//  Created by Alaina Thompson on 2/18/22.
//

import SwiftUI
import CorePlot


typealias plotDataType = [CPTScatterPlotField : Double]

struct ContentView: View {
    
   
    
    @State var psi_String = "0.0"
    
    @ObservedObject var diffModel = DiffEq()

    var body: some View {
        
        
        VStack(alignment: .center) {
            Text("psi")
                .font(.callout)
                .bold()
            TextField("", text: $psi_String)
                .padding()
        }
        
       
        
        
        
        Button("Calculate", action: {Task.init{await self.calculateDiff()}})
            .padding()
            .disabled(diffModel.enableButton == false)
    
    }

    func calculateDiff() async {
    
        diffModel.setButtonEnable(state: false)
    
        let _ : Bool = await diffModel.initWithDiff()
    
    }

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

