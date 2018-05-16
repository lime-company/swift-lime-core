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

/// The `GenericLocalizationProvider` protocol defines simple interface
/// which provides strings localizations.
///
/// `LimeCore` provides two different classes implementing this protocol:
/// - `SystemLocalizationProvider` - implements localization with using `NSLocalizedString`. The behavior
///    of this provides is the same as `NSLocalizedString()` function.
/// - `LocalizationProvider` - implements advanced localization, which allows for example dynamic
///    language change in the runtime.
public protocol GenericLocalizationProvider: class {
    
    /// Returns localized string for given key.
    func localizedString(_ key: String) -> String
}
