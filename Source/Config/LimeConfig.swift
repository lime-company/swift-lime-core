//
// Copyright 2018 Wultra s.r.o.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions
// and limitations under the License.
//

import Foundation

public protocol ImmutableConfig {
}

public protocol MutableConfig: ImmutableConfig {
    func makeImmutable() -> ImmutableConfig
}

public class LimeConfig {

    let lock = LimeCore.Lock()

    var configs = [String:ImmutableConfig]()
    var mutableConfigs = [(domain: String, config: MutableConfig)]()

    var initialRegistration = true
    
    internal init() {
    }
}

// MARK: - Immutable access -

public extension LimeConfig {
    
    /// Returns copy of confing object for requested domain or nil if there's no such domain registered.
    public func config<T: ImmutableConfig>(for domain: String) -> T? {
        return lock.synchronized { () -> T? in
            guard let c = self.configs[domain] as? T else {
                D.error("LimeConfig: Domain '\(domain)' is not registered.")
                return nil
            }
            return c;
        }
    }
    
    /// Returns true if config is registered
    public func contains(domain: String) -> Bool {
        return lock.synchronized { () -> Bool in
            return self.configs[domain] != nil
        }
    }
}



// MARK: - Mutable access -

public extension LimeConfig {
    
    /// Registers a new config domain.
    public func register<T: ImmutableConfig>(_ immutableObject: T, for domain: String) -> Void {
        return lock.synchronized { () in
            if self.initialRegistration == false {
                D.error("LimeConfig: Cannot register additional domain '\(domain)'.")
                return
            }
            if let cfg = self.configs[domain] {
                if cfg is T {
                    // You don't need to register the same config for twice
                    D.warning("LimeConfig: Domain '\(domain)' is already registered for this type.")
                } else {
                    // You're registering different object type for the same domain
                    D.error("LimeConfig: Domain '\(domain)' is already registered for another object type.")
                }
                return
            }
            self.configs[domain] = immutableObject
        }
    }
    
    /// Registers a new config domain.
    public func register<T: MutableConfig>(_ mutableObject: T, for domain: String) -> T? {
        return lock.synchronized { () in
            if self.initialRegistration == false {
                D.error("LimeConfig: Cannot register additional domain '\(domain)'.")
                return nil
            }
            if let cfg = self.configs[domain] {
                if let typedCfg = cfg as? T {
                    // You don't need to register the same config for twice
                    D.warning("LimeConfig: Domain '\(domain)' is already registered for this type.")
                    return typedCfg
                }
                // You're registering different object type for the same domain
                D.error("LimeConfig: Domain '\(domain)' is already registered for another object type.")
                return nil
            }
            self.mutableConfigs.append((domain, mutableObject))
            self.configs[domain] = mutableObject.makeImmutable()
            return mutableObject
        }
    }
    
    /// Updates immutable config for given domain. The `update` closure gets current config object and must return new one.
    public func update<T: ImmutableConfig>(domain: String, update: (T)->T) {
        lock.synchronized { () in
            if let current = self.configs[domain] as? T {
                self.configs[domain] = update(current)
            } else {
                D.error("LimeConfig: Domain '\(domain) is not registered and therefore config cannot be updated.")
            }
        }
    }

    /// Updates mutable config for given domain. The `update` closure gets current mutable object, which can be modified
    /// in the scope of closure (e.g. you should not keep reference to that object for later modifications).
    public func update<T: MutableConfig>(domain: String, update: (T)->Void) {
        lock.synchronized { () in
            if let current = self.configs[domain] as? T {
                update(current)
                self.configs[domain] = current.makeImmutable()
            } else {
                D.error("LimeConfig: Domain '\(domain) is not registered and therefore config cannot be updated.")
            }
        }
    }
    
    /// Internal function closes opportunity for initial configs registration.
    internal func closeInitialRegistration() {
        lock.synchronized {
            self.initialRegistration = false
            self.mutableConfigs.forEach { (cfg) in
                self.configs[cfg.domain] = cfg.config.makeImmutable()
            }
            self.mutableConfigs.removeAll()
        }
    }
}
