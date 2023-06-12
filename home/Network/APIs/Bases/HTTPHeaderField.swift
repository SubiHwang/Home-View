//
//  HTTPHeaderField.swift
//  home
//
//  Created by 황수비 on 2023/05/29.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "Application/json"
}
