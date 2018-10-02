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

public extension LimeConfig {
    
    /// Returns the shared default object.
    /// Before accessing this singleton object, you have to setup
    /// `LimeConfig.registerConfigDomains` otherwise the fatal error is raised.
    public static let shared = LimeConfig.sharedConfig()
    
    public static var registerConfigDomains: ((LimeConfig)->Void)?
    
    internal static func sharedConfig() -> LimeConfig {
        // Create shared config
        let config = LimeConfig()
        // Call registration closure
        guard let registrationBlock = registerConfigDomains else {
            LimeDebug.fatalError("LimeConfig.onRegisterDomains is not set.")
        }
        
        // Call & cleanup registration block
        registrationBlock(config)
        registerConfigDomains = nil
        
        // Close registration & return config object.
        config.closeInitialRegistration()
        return config
    }
    
}
