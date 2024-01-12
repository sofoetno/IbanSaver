//
//  PersonModel.swift
//  IbanSaver
//
//  Created by Levan Loladze on 11.01.24.
//

import Foundation

struct PersonModel {
    let fullName: String
    let avatarName: String
    let savedIbans: [IbanModel]
    let isMale: Bool
}
