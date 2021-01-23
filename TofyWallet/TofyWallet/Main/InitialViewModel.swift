//
//  InitialViewModel.swift
//  TofyWallet
//
//  Created by usuario on 23/1/21.
//

import Foundation
import SwiftUI
import Combine

enum TipoInicio{
    case login
    case main
}

class InitialViewModel: ObservableObject{
    
    @Published var inicio: TipoInicio?
    
    func initApp(){
        inicio = .main
    }
    
}
