//
//  APIKeys.swift
//  MovieAPICombine
//
//  Created by Weerawut Chaiyasomboon on 07/03/2568.
//

import Foundation

struct APIKeys {
    static func getMovieKey() -> String? {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            return dict["movieKey"] as? String
        }
        return nil
    }
}
