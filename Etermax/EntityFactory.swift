//
//  EntityFactory.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import Jayme

open class EntityFactory<EntityType: FactoryInitializable> {
    
    public init() { }
    
    open func entity(from dictionary: [AnyHashable: Any]) -> Future<DictionaryInitializable, JaymeError> {
        return Future() { completion in
            guard let entity = try? EntityType.factoryMethod(dictionary: dictionary) else {
                completion(.failure(.parsingError))
                return
            }
            completion(.success(entity))
        }
    }
    
    open func entities(from dictionaries: [[AnyHashable: Any]]) -> Future<[DictionaryInitializable], JaymeError> {
        return Future() { completion in
            let entities = dictionaries.flatMap({ try? EntityType.factoryMethod(dictionary: $0) })
            completion(.success(entities))
        }
    }
}
