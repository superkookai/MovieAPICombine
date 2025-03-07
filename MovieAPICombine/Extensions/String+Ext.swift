//
//  String+Ext.swift
//  MoviesAppUIKit
//
//  
//

import Foundation

extension String {
    
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}
