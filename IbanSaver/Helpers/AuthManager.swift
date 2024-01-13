//
//  AuthManager.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 11.01.24.
//

import FirebaseAuth

final class AuthManager {
    
    // MARK: - Properties
    static let shared = AuthManager()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Methods
    func creatUser(email: String, password: String) async throws -> AuthDataResultModel {
        let registaredDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(uid: registaredDataResult.user.uid, email: registaredDataResult.user.email)
        return result
    }
}
