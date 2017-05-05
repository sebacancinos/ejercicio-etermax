// Jayme
// Updatable.swift
//
// Copyright (c) 2016 Inaka - http://inaka.net/
//
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements. See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership. The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License. You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

import Foundation

/// A repository that is capable of updating entities
public protocol Updatable: Repository {
    associatedtype EntityType: Identifiable, DictionaryInitializable, DictionaryRepresentable
    var backend: URLSessionBackend { get }
}

public extension Updatable {
    
    /// Requests the only entity in the repository to be updated in the backend. Returns a `Future` with the updated entity or a `JaymeError`.
    public func update(_ entity: EntityType) -> Future<EntityType, JaymeError> {
        let path = "\(self.name)"
        return self.backend.future(path: path, method: .PUT, parameters: entity.dictionaryValue)
            .andThen { DataParser().dictionary(from: $0.0) }
            .andThen { EntityParser().entity(from: $0) }
    }
    
    /// Requests the entity with the given `id` to be updated in the backend. Returns a `Future` with the updated entity or a `JaymeError`.
    public func update(_ entity: EntityType, id: EntityType.IdentifierType) -> Future<EntityType, JaymeError> {
        let path = "\(self.name)/\(entity.id)"
        return self.backend.future(path: path, method: .PUT, parameters: entity.dictionaryValue)
            .andThen { DataParser().dictionary(from: $0.0) }
            .andThen { EntityParser().entity(from: $0) }
    }
    
    /// Requests the given entities to be updated in the backend. Returns a `Future` with the updated entities or a `JaymeError`.
    public func update(_ entities: [EntityType]) -> Future<[EntityType], JaymeError> {
        let path = self.name
        let parameters = entities.map { $0.dictionaryValue }
        return self.backend.future(path: path, method: .PATCH, parameters: parameters)
            .andThen { DataParser().dictionaries(from: $0.0) }
            .andThen { EntityParser().entities(from: $0) }
    }
    
}
