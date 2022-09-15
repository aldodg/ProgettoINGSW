//
//  DataFetchPhase.swift
//  CineMates
//
//  Created by Aldo Di Giovanni on 26/12/21.
//  Copyright © 2021 Aldo Di Giovanni. All rights reserved.
//

import Foundation

enum DataFetchPhase<V> {
    
    case empty
    case success(V)
    case failure(Error)
    
    var value: V? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
}
