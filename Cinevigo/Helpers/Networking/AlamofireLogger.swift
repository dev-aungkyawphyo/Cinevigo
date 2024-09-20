//
//  AlamofireLogger.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import Foundation
import Alamofire

final class AlamofireLogger: EventMonitor {
    
    func requestDidResume(_ request: Request) {
        
        let allHeaders = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.debugDescription } } ?? "None"
        let headers = """
         \("\u{1f7e0}".decode()) Request Started => \(request)
         \("\u{1f7e0}".decode()) Headers => \(allHeaders as Any)
        """
        printDebug("============================ Start Headers ==============================")
        printDebug(headers)
        printDebug("============================ End Headers ================================")
        
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
         \("\u{1f7e1}".decode()) Request Started => \(request)
         \("\u{1f7e1}".decode()) Body Data => \(body)
        """
        
        printDebug("============================ Start Body ==============================")
        printDebug(message)
        printDebug("============================ End Body ================================")
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        printDebug(" \("\u{1f7e2}".decode()) Response Received:")
        printDebug(response.data?.prettyPrintedJSONString as Any)
        printDebug(" \("\u{1f535}".decode()) Response All Headers:")
        printDebug(String(describing: response.response?.allHeaderFields))
    }
    
}
