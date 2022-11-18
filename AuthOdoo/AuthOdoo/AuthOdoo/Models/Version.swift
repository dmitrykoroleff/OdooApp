//
//  Version.swift
//  AuthOdoo
//
//  Created by Melanie Kofman on 16.11.2022.
//

import Foundation
struct ServerVersion: Decodable, Equatable {
    let serverVersion: String
    let serverSeries: String
    let protocolVersion: Int

    enum CodingKeys: String, CodingKey {
        case serverVersion = "server_version"
        case serverSeries = "server_serie"
        case protocolVersion = "protocol_version"
    }
    
    init(serverVersion: String, serverSeries: String, protocolVersion: Int) {
        self.serverVersion = serverVersion
        self.serverSeries = serverSeries
        self.protocolVersion = protocolVersion
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        serverVersion = try values.decode(String.self, forKey: .serverVersion)
        serverSeries = try values.decode(String.self, forKey: .serverSeries)
        protocolVersion = try values.decode(Int.self, forKey: .protocolVersion)
    }
}

struct ServerVersionResult: Decodable, Equatable {
    let result: ServerVersion
}
