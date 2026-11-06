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

import ohos.business_exception.AsyncCallback
import ohos.labels.APILevel
import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.multimedia.camera as camera
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
}

/**
 * Defines the configuration information about the camera picker.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class PickerProfile {
    /**
     * Camera position.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop cameraPosition: camera.CameraPosition {
        get() {
            camera.CameraPosition.CameraPositionUnspecified
        }
        set(v) {
        }
    }

    /**
     * URI for saving the configuration information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop saveUri: ?String {
        get() {
            None
        }
        set(v) {
        }
    }

    /**
     * Maximum video duration, in seconds.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop videoDuration: ?Int32 {
        get() {
            None
        }
        set(v) {
        }
    }

    /**
     * A constructor used to create a PickerProfile.
     *
     * @param { camera.CameraPosition } cameraPosition - Camera position.
     * @param { ?String } [saveUri] - URI for saving the configuration information.
     * @param { ?Int32 } [videoDuration] - Maximum video duration, in seconds.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public init(cameraPosition: camera.CameraPosition, saveUri!: ?String = None, videoDuration!: ?Int32 = None) {
    }
}

/**
 * Defines the processing result of the camera picker.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class PickerResult {
    /**
     * Result code. The value **0** means that the processing is successful, and **-1** means that the processing fails.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop resultCode: Int32 {
        get() {
            0
        }
        set(v) {
        }
    }

    /**
     * URI of the result.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop resultUri: String {
        get() {
            ""
        }
        set(v) {
        }
    }

    /**
     * Media type.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop mediaType: PickerMediaType {
        get() {
            PickerMediaType.Photo
        }
        set(v) {
        }
    }

    init(resultCode: Int32, resultUri: String, mediaType: PickerMediaType) {
    }
}

/**
 * Starts the camera picker and enters the corresponding mode based on the media type. This API uses an asynchronous
 * callback to return the result.
 *
 * @param { UIAbilityContext } context - Application context.
 * @param { Array<PickerMediaType> } mediaTypes - Media type.
 * @param { PickerProfile } pickerProfile - Profile of the camera picker.
 * @param { AsyncCallback<PickerResult> } callback - Callback used to return the processing result
 *     (**PickerResult**) of the camera picker.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public func pick(context: UIAbilityContext, mediaTypes: Array<PickerMediaType>, pickerProfile: PickerProfile,
    callback: AsyncCallback<PickerResult>): Unit {
    callback(None, Some(PickerResult(0, "", PickerMediaType.Photo)))
}
