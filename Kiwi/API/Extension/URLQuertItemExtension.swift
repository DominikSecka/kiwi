//
//  URLQuertItemExtension.swift
//  Kiwi
//
//  Created by Dominik Secka on 26/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import Foundation

extension URLQueryItem {

    init<Name: RawRepresentable, Value: LosslessStringConvertible>(name: Name, value: Value...) where Name.RawValue == String {
        self.init(name: name, value: value.map({ String($0) }))
    }
    
    init<Name: RawRepresentable, Value: RawRepresentable>(name: Name, value: Value...) where Name.RawValue == String, Value.RawValue: LosslessStringConvertible {
        self.init(name: name, value: value.map({ String($0.rawValue) }))
    }

    init<Name, Value>(name: Name, value: Value) where Name: RawRepresentable, Name.RawValue == String, Value: Sequence, Value.Element: StringProtocol {
        self.init(name: name.rawValue, value: value.joined(separator: ","))
    }
    
    init<Name, Value>(name: Name, value: Value) where Name: RawRepresentable, Name.RawValue == String, Value: Sequence, Value.Element: LosslessStringConvertible {
        if let justString = value as? String {
            self.init(name: name.rawValue, value: justString)
        } else {
            self.init(name: name.rawValue, value: value.map({ String($0) }).joined(separator: ","))
        }
    }
    
    init<Name, Value>(name: Name, value: Value) where Name: RawRepresentable, Name.RawValue == String, Value: Sequence, Value.Element: RawRepresentable, Value.Element.RawValue: LosslessStringConvertible {
        self.init(name: name.rawValue, value: value.map({ String($0.rawValue) }).joined(separator: ","))
    }
}
