//
//  Subscriber+Extension.swift
//  Shift
//
//  Created by ziad on 3/28/20.
//  Copyright © 2020 generation-c. All rights reserved.
//

import Combine
public extension Subscribers.Completion {
   public var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
