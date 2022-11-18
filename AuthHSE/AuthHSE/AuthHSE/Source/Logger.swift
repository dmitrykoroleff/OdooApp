//
//  Logger.swift
//  odooapp
//
//  Created by Данила on 23.10.2022.
//

import os.log

struct Logger {
    
    static func error(data: String) {
        os_log("%s", type: .error, data)
    }

    static func info(data: String) {
        os_log("%s", type: .info, data)
    }

    static func debug(data: String) {
        os_log("%s", type: .debug, data)
    }
}
