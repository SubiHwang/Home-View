//
//  LoginResponse.swift
//  home
//
//  Created by 황수비 on 2023/05/29.
//

import Foundation

struct LoginResponse: Decodable {
    let access: String
    let refresh: String
}

//LoginResponse의 인스턴스를 Auth 모델로 변환하여 사용하기 쉽게 해주는 메소드
extension LoginResponse {
    var toDomain: Auth {
        Auth.shared.access = access
        Auth.shared.refresh = refresh
        return Auth.shared
    }
}
