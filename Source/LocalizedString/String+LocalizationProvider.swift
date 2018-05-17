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

public extension String {
    
    /// Returns localized version of this string. You can simply call `"Hello World".localized` to localize "my.key" string.
    ///
    /// ## Warning
    /// This variable is by default not compiled into the LimeCore framework, but you can import it into your project with
    /// using appropriate cocoapod: `pod 'LimeCore/LocalizedString'`
    public var localized: String {
        return LocalizationProvider.shared.localizedString(self)
    }
    
    /// Returns parametrized localized version of this string. You can simply call "This is %@ %@".localized("hello", "world") to
    /// produce "This is hello world" string.
    ///
    /// The function at first converts this string into localized string and then it tries to produce formatted string with
    /// using provided arguments. You must guarantee that there's enough parameters for successful localization. The format
    /// of formatted string is the same as is used in the objective-c `[NSString stringWithFormat:...]`
    ///
    /// ## Warning
    /// This method is by default not compiled into the LimeCore framework, but you can import it into your project with
    /// using appropriate cocoapod: `pod 'LimeCore/LocalizedString'`
    public func localized(_ args: CVarArg...) -> String {
        return LocalizationProvider.shared.localizedFormattedString(self, args)
    }
}
