//
//  UserTarget.swift
//  home
//
//  Created by 황수비 on 2023/05/29.
//

//백엔드에게 요청을 보내는 코드
import Foundation
import Alamofire

enum UserTarget{
    case Login(LoginRequest)
    case Register(RegisterRequest)
}

extension UserTarget: TargetType {
    //엔드포인트 주소 메소드
    var baseURL: String {
        return "https://hey-groot-api.fly.dev/user"
    }
    
    //기능별 추가되는 주소 메소드
    var path: String{
        switch self{
        case .Login: return "/auth/login/"
        case .Register: return "/auth/registration/"
        }
    }
    
    //요청 메소드
    var method: HTTPMethod {
        switch self {
        case .Login: return .post
        case .Register: return .post
        }
    }
    
    //백엔드로 정보를 넘겨주는 메소드
    var parameters: RequestParams? {
        switch self {
        case .Login(let request): return .body(request)
        case .Register(let request): return .body(request)
        }
    }
}
