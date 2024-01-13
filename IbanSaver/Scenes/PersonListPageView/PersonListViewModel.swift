//
//  PersonListViewModel.swift
//  IbanSaver
//
//  Created by Levan Loladze on 13.01.24.
//

import Foundation

class PersonListViewModel {
    
    // MARK: - Properties
    var persons: [PersonModel] = [
        PersonModel(fullName: "levaniko Dzlieri", avatarName: "male1", savedIbans: [], isMale: true),
        PersonModel(fullName: "giviko Lamazi", avatarName: "female3", savedIbans: [], isMale: false),
        PersonModel(fullName: "Jemal loladze", avatarName: "male3", savedIbans: [], isMale: true),
        PersonModel(fullName: "nataliko", avatarName: "female1", savedIbans: [], isMale: false),
    ] {
        didSet {
            persons.sort { $0.fullName < $1.fullName }
        }
    }
    
    // MARK: - Init
    init() {
        self.persons = persons.sorted { $0.fullName < $1.fullName }
    }
}
