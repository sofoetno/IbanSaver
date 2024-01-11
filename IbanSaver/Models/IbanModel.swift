//
//  IbanModel.swift
//  IbanSaver
//
//  Created by Levan Loladze on 11.01.24.
//

import Foundation

struct IbanModel {
    let ibanNumber: String
    let bankImage: bankSelect
}
 
enum bankSelect: String {
    case Bog = "BOG"
    case TBC = "TBC"
    case Credo = "Credo"
    case ProcreditBank = "Procredit"
}
