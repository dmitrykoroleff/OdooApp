//
//  ContentView.swift
//  odooapp
//
//  Created by Melanie Kofman on 11.11.2022.
//

import SwiftUI
import AuthHSE
import YandexMobileMetrica
import FirebaseRemoteConfig

struct AppView: View {
    init() {
        metricaStart()
        print("metrica started")
//        print(RemoteConfig.remoteConfig().configValue(forKey: "isHseAuthEnabled").boolValue)
    }
    var body: some View {
        AuthHSE.AuthView().onAppear {
            Thread.sleep(forTimeInterval: 1.0)
            CookieFile().getError()
//            RCValues().fetchCloudValues()
        }
    }
    
    func metricaStart() {
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "ecbc98ca-f03d-4409-a73a-fd6f48d2dc33")
            YMMYandexMetrica.activate(with: configuration!)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

