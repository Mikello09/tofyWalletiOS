//
//  HomeViewModel.swift
//  TofyWallet
//
//  Created by usuario on 23/1/21.
//

import Foundation
import SwiftUI
import Combine


class HomeViewModel: ObservableObject{
    
    @Published var items: [HomeItem]?
    
    func getItems(){
        var itemsToShow: [HomeItem] = []
        itemsToShow.append(.grupo)
        itemsToShow.append(.perfil)
        itemsToShow.append(.info)
        items = itemsToShow
    }
    
}
