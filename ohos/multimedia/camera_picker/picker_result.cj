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

/**
 * Defines the processing result of the camera picker.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class PickerResult {
    private let pickerResultImpl: PickerResultImpl

    /**
     * Result code. The value **0** means that the processing is successful, and **-1** means that the processing fails.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop resultCode: Int32 {
        get() {
            pickerResultImpl.resultCode
        }
        set(v) {
            pickerResultImpl.resultCode = v
        }
    }

    /**
     * URI of the result. If **saveUri** is empty, **resultUri** is a public media path. If **saveUri** is not empty and
     * the application has the write permission on the URI, the value of **resultUri** is the same as that of
     * **saveUri**. If **saveUri** is not empty and the application does not have the write permission on the URI,
     * **resultUri** cannot be obtained.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop resultUri: String {
        get() {
            pickerResultImpl.resultUri
        }
        set(v) {
            pickerResultImpl.resultUri = v
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
            pickerResultImpl.mediaType
        }
        set(v) {
            pickerResultImpl.mediaType = v
        }
    }

    init(resultCode: Int32, resultUri: String, mediaType: PickerMediaType) {
        pickerResultImpl = PickerResultImpl(resultCode, resultUri, mediaType)
    }
}

class PickerResultImpl {
    var resultCode: Int32
    var resultUri: String
    var mediaType: PickerMediaType

    init(resultCode: Int32, resultUri: String, mediaType: PickerMediaType) {
        this.resultCode = resultCode
        this.resultUri = resultUri
        this.mediaType = mediaType
    }
}
