//
//  HistoricoViewModel.swift
//  TofyWallet
//
//  Created by Mikel on 9/2/21.
//

import Foundation
import Combine


class HistoricoViewModel: ObservableObject{
    
    @Published var years: [Int]?
    
    
    func getYears(){
        var anos: [Int] = []
        for periodo in GrupoManager.shared.periodos ?? []{
            let ano = periodo.fechaInicio?.toDate().getYearFromDate() ?? 0
            if anos.isEmpty{
                anos.append(ano)
            } else {
                if !anos.contains(ano){
                    anos.append(ano)
                }
            }
        }
        self.years = anos
    }
    
    
}
