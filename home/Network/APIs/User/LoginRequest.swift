//
//  LoginRequest.swift
//  home
//
//  Created by 황수비 on 2023/05/29.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}
