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

/// The LimeDebug class provides simple logging facility available for DEBUG
/// build of the library.
///
/// Recommended usage in Lime libraries:
/// ```
/// internal typealias D = LimeDebug
///
/// func someFunc() {
///    D.print("This is debug information.")
/// }
/// ```
public class LimeDebug {
    
    /// If false, then messages logged with `LimeDebug.print()` are silently ignored.
    public static var isEnabled = false
    
    /// Prints simple message to the debug console.
    public static func print(_ message: String) {
        #if DEBUG
            if isEnabled {
                Swift.print("[LimeDebug] \(message)")
            }
        #endif
    }

    public static func warning(_ message: String) {
        #if DEBUG
            Swift.print("[LimeDebug] WARNING: \(message)")
        #endif
    }
    
    public static func error(_ message: String) {
        #if DEBUG
            Swift.print("[LimeDebug] ERROR: \(message)")
        #endif
    }
}

internal typealias D = LimeDebug
