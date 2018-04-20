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

/// The `LocalizationTransformation` protocol defines interface for string table transformation
/// applied after string table is loaded into the memory. This is typically useful when you
/// need to patch string table once per its load into the memory.
///
/// ## Example for TouchID and FaceID
///
/// Imagine that you have separate sets of keys for TouchID and FaceID related string. Those will never
/// be used at the same time, because there's no such device, supporting both technologies.
///
/// This fact allows you implement your own transformation which will do following operations:
///    - If device supports **TouchID**, then remove FaceID related keys
///    - If device supports **FaceID**, then move all FaceID to TouchID keys
///
/// As you can see, from now, you can use only **TouchID** related keys in application's code, because
/// all strings will be patched at the string table loading time.
///
public protocol LocalizationTransformation: class {
    
    /// Implementation can decide which operation has to be performed for given key.
    func transform(key: String) -> LocalizationTransformationOperation
}


/// The `LocalizationTransformationOperation` enumeration describes operation
/// which has to be ferformed for given key in `LocalizationTransformation`
public enum LocalizationTransformationOperation {
    /// Localized string will stay in final string table under the original key.
    case keep
    /// Localized string will be removed from final string table.
    case erase
    /// Localized string will be stored under the new key, provided as case parameter.
    case moveTo(key: String)
    /// Localized string will be stored under the original and also the new key, provided as case parameter.
    case copyTo(key: String)
}
