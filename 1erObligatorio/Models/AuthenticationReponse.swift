//
//  AuthenticationReponse.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/21/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation

class AuthenticationResponse {
    var token: String
    
    init(token: String) {
        print(token)
        self.token = token
    }
}
