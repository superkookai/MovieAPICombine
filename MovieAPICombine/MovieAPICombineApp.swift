//
//  MovieAPICombineApp.swift
//  MovieAPICombine
//
//  Created by Weerawut Chaiyasomboon on 07/03/2568.
//

import SwiftUI

@main
struct MovieAPICombineApp: App {
    private let httpClient = HTTPClient()
    
    var body: some Scene {
        WindowGroup {
            ContentView(httpClient: httpClient)
        }
    }
}
