//
//  FactoryInitializable.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import Jayme

public protocol FactoryInitializable {
    static func factoryMethod(dictionary: [AnyHashable: Any]) throws -> DictionaryInitializable
}
