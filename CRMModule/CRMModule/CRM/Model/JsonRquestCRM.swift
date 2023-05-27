//
//  JsonRequestCRM.swift
//  CRMModule
//
//  Created by Данила on 22.05.2023.
//

import Foundation

class JsonCRM {
//MARK: json для тела запросов
    let jsonCRM: [String: Any] = ["id": 100,
                               "jsonrpc": "2.0",
                               "method": "call",
                               "params": [
                                    "fields": [],
                                    "model": "crm.lead"]]
    
    let jsonCRMStage: [String: Any] = ["id": 100,
                               "jsonrpc": "2.0",
                               "method": "call",
                               "params": [
                                    "fields": [],
                                    "model": "crm.stage"]]
    
    func getLogNotes(thread: Int) -> [String: Any] {
        let json: [String: Any] = ["id": 100,
                                   "jsonrpc": "2.0",
                                   "method": "call",
                                   "params": [
                                        "thread_id": thread,
                                        "limit": 30,
                                        "thread_model": "crm.lead"]]
        return json
    }
    func getActivity(ids: Array<Int>) -> [String: Any] {
        let json: [String: Any] = ["id": 100,
                                   "jsonrpc": "2.0",
                                   "method": "call",
                                   "params": [
                                    "model": "mail.activity",
                                    "args": [ids],
                                    "method": "activity_format",
                                    "kwargs": [:]
                                   ]]
        
        return json
    }
    
    func setLog(thread: Int, message: String) -> [String: Any] {
        let json: [String: Any] = [
            "id": 100,
            "jsonrpc": "2.0",
            "method": "call",
            "params": [
                "post_data": [
                    "body": message,
                    "message_type": "comment",
                    "subtype_xmlid": "mail.mt_note"
                ],
                "thread_id": thread,
                "thread_model": "crm.lead"
            ]
        ]
        return json
    }
    
}
