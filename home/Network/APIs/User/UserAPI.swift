//
//  UserAPI.swift
//  home
//
//  Created by 황수비 on 2023/05/29.
//

//요청한 정보를 받아 사용하고, 실제 백엔드와 통신하는 코드
import Foundation
import Alamofire

struct UserAPI{
    //로그인
    //LoginRequest: 로그인 요청에 필요한 데이터를 담고 있는 모델
    //AF.request()를 사용하여 실제로 서버로 로그인 요청을 보냄
    //UserServiceTarget.Login(request)를 전달하여 로그인 요청의 목표(Target)을 설정. 이를 통해 요청의 URL, 메서드, 바디 등이 구성
    static func Login(request: LoginRequest, completion: @escaping (_ succeed: Auth?, _ failed: Error?) -> Void) {
        AF.request(UserTarget.Login(request))
            .responseDecodable { (response: AFDataResponse<LoginResponse>) in
                switch response.result {
                    //성공적인 응답의 경우 Auth모델이 완료 핸들러에 전달됨
                case .success(let response):
                    completion(response.toDomain, nil)
                    //실패할 경우 Error 객체가 완료 핸들어에 전달됨
                case .failure(let error):
                    completion(nil, error)
                }
            }
        
    }
    
    //회원가입
    static func Register(){
        
    }
}




