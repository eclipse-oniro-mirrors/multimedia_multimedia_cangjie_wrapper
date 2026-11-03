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

import ohos.labels.APILevel
import ohos.multimedia.camera as camera

/**
 * Defines the configuration information about the camera picker.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class PickerProfile {
    private let pickerProfileImpl: PickerProfileImpl

    /**
     * Camera position.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop cameraPosition: camera.CameraPosition {
        get() {
            pickerProfileImpl.cameraPosition
        }
        set(v) {
            pickerProfileImpl.cameraPosition = v
        }
    }

    /**
     * URI for saving the configuration information. For details about the default value, see **File URI**. The
     * **saveUri** parameter is optional. If it is not specified, images and videos are automatically saved to the media
     * library. To prevent them from being saved to the media library, specify a valid file path within your
     * application's sandbox. When you use your own resource path, ensure that the file exists and is writable;
     * otherwise, the save operation fails.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop saveUri: ?String {
        get() {
            pickerProfileImpl.saveUri
        }
        set(v) {
            pickerProfileImpl.saveUri = v
        }
    }

    /**
     * Maximum video duration, in seconds. The default value is **0**, indicating that the maximum video duration is not
     * set.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop videoDuration: ?Int32 {
        get() {
            pickerProfileImpl.videoDuration
        }
        set(v) {
            pickerProfileImpl.videoDuration = v
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
        pickerProfileImpl = PickerProfileImpl(cameraPosition, saveUri, videoDuration)
    }

    func getCameraPositionValue(): Int32 {
        match (pickerProfileImpl.cameraPosition) {
            case camera.CameraPosition.CameraPositionUnspecified => 0
            case camera.CameraPosition.CameraPositionBack => 1
            case camera.CameraPosition.CameraPositionFront => 2
            // CameraPositionFoldInner is same as Front
            case _ => 2
        }
    }
}

class PickerProfileImpl {
    var cameraPosition: camera.CameraPosition
    var saveUri: ?String
    var videoDuration: ?Int32

    init(cameraPosition: camera.CameraPosition, saveUri: ?String, videoDuration: ?Int32) {
        this.cameraPosition = cameraPosition
        this.saveUri = saveUri
        this.videoDuration = videoDuration
    }
}
