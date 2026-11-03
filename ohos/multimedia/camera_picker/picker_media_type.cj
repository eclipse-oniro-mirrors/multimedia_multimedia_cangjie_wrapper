/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.multimedia.camera_picker

import ohos.business_exception.{BusinessException, ERR_PARAMETER_ERROR}
import ohos.labels.APILevel
import std.deriving.Derive

/**
 * Enumerates the media types displayed in the camera picker.
 */
@Derive[ToString, Equatable, Hashable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum PickerMediaType {
    /**
     * Photo mode.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Photo
    |
    /**
     * Video mode.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    Video
    | ...

    func getValue(): Int32 {
        match (this) {
            case Photo => 0
            case Video => 1
            case _ => throw BusinessException(ERR_PARAMETER_ERROR, "Parameter error.")
        }
    }

    static func parse(code: Int32): PickerMediaType {
        match (code) {
            case 0 => Photo
            case 1 => Video
            case _ => Photo
        }
    }
}
