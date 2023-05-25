//
//  JsonRequestCRM.swift
//  CRMModule
//
//  Created by Данила on 22.05.2023.
//

import Foundation

class JsonCRM {
//MARK: json для тела запросов
    let jsonStageId: [String: Any] = ["id": 100,
                               "jsonrpc": "2.0",
                               "method": "call",
                               "params": [
                                    "fields": [],
                                    "model": "crm.lead"]]
}
