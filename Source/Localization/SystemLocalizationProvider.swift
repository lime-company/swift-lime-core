//
// Copyright 2018 Lime - HighTech Solutions s.r.o.
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

/// The `SystemLocalizationProvider` class wraps `NSLocalizedString()` into interface conforming to
/// `GenericLocalizationProvider`. The class is typically used as a default provider in Lime's public
/// open source libraries, where we don't want to force usage of our more feature `LocalizationProvider`.
/// The best example is our [LimeAuth](https://github.com/lime-company/swift-lime-auth) library.
public class SystemLocalizationProvider: GenericLocalizationProvider {
  
    /// Name of string table
    private let tableName: String?
    
    /// Bundle in which is the string table stored
    private let bundle: Bundle
    
    /// Initializes the provider.
    /// - parameter tableName: Name of the string table.
    /// - parameter bundle: Bundle in which is the string table stored. By default, `Bundle.main` is used
    public init(tableName: String? = nil, bundle: Bundle = .main) {
        self.tableName = tableName
        self.bundle = bundle
    }
    
    /// Returns localized string for given key.
    public func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, tableName: tableName, bundle: bundle, comment: "")
    }
}
