//
//  CombineTypeAlais.swift
//  Shift
//
//  Created by ziad on 4/14/20.
//  Copyright © 2020 generation-c. All rights reserved.
//

import Combine

public typealias Relay<T> = CurrentValueSubject<T,Never>
public typealias Subject<T> =  PassthroughSubject<T,Never>
public typealias AnyDrive<T> = AnyPublisher<T,Never>
public typealias Drive<T> = Published<T>.Publisher
