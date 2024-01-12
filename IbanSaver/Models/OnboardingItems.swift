//
//  OnboardingItems.swift
//  IbanSaver
//
//  Created by Nika Jamatashvili on 12.01.24.
//

import SwiftUI

struct OnboardingItem: Identifiable {
    let id = UUID().uuidString
    let OBBGColor: Color
    let OBImage: String
    let OBTitle: String
    let OBSubtitle: String
    
}

let OBData = [
    OnboardingItem(
        OBBGColor: AppColors.silver,
        OBImage: "OBInputImage",
        OBTitle: "Add New Person",
        OBSubtitle: "Enter the person's name, surname, and iBan number to start managing their financial details."
    ),
    
    OnboardingItem(
        OBBGColor: AppColors.silver,
        OBImage: "OBPersonListImage",
        OBTitle: "Manage Persons",
        OBSubtitle: "View and organize a list of individuals along with their associated iBan numbers. Easily add or remove entries as needed. "
    ),
    
    OnboardingItem(
        OBBGColor: AppColors.silver,
        OBImage: "OBPersonsIbanListImage",
        OBTitle: "Manage iBan Numbers",
        OBSubtitle: "Explore the list of iBan numbers associated with each person. Keep track of multiple iBans for efficient financial management. "
    )
]
