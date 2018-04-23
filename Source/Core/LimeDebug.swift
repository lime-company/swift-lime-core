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
    
    /// Defines verbose level for this simple debugging facility.
    public enum VerboseLevel: Int {
        /// Silences all messages.
        case off = 0
        /// Only errors will be printed to the debug console.
        case errors = 1
        /// Errors and warnings will be printed to the debug console.
        case warnings = 2
        /// All messages will be printed to the debug console.
        case all = 3
    }
    
    /// Current verbose level. Note that value is ignored for non-DEBUG builds.
    public static var verboseLevel: VerboseLevel = .warnings
    
    /// Prints simple message to the debug console.
    public static func print(_ message: @autoclosure ()->String) {
        #if DEBUG
        if verboseLevel == .all {
            Swift.print("[LimeDebug] \(message())")
        }
        #endif
    }

    /// Prints warning message to the debug console.
    public static func warning(_ message: @autoclosure ()->String) {
        #if DEBUG
        if verboseLevel.rawValue >= VerboseLevel.warnings.rawValue {
            Swift.print("[LimeDebug] WARNING: \(message())")
        }
        #endif
    }
    
    /// Prints error message to the debug console.
    public static func error(_ message: @autoclosure ()->String) {
        #if DEBUG
        if verboseLevel != .off {
            Swift.print("[LimeDebug] ERROR: \(message())")
        }
        #endif
    }
}

internal typealias D = LimeDebug
