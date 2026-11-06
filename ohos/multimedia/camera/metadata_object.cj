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

package ohos.multimedia.camera

import ohos.labels.APILevel

/**
 * Describes the camera metadata, which is the data source of **CameraInput**. The metadata is obtained through
 * **MetadataOutput.onMetadataObjectsAvailable**.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public open class MetadataObject {
    private let metadataObjectImpl: MetadataObjectImpl

    /**
     * Metadata object type.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public prop metadataObjectType: MetadataObjectType {
        get() {
            metadataObjectImpl.metadataObjectType
        }
    }

    /**
     * Timestamp, in ns.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public prop timestamp: Int64 {
        get() {
            metadataObjectImpl.timestamp
        }
    }

    /**
     * Metadata rectangle.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public prop boundingBox: Rect {
        get() {
            metadataObjectImpl.boundingBox
        }
    }

    init(metadataObjectType: MetadataObjectType, timestamp: Int64, boundingBox: Rect) {
        metadataObjectImpl = MetadataObjectImpl(metadataObjectType, timestamp, boundingBox)
    }
}

class MetadataObjectImpl {
    let metadataObjectType: MetadataObjectType
    let timestamp: Int64
    let boundingBox: Rect

    init(metadataObjectType: MetadataObjectType, timestamp: Int64, boundingBox: Rect) {
        this.metadataObjectType = metadataObjectType
        this.timestamp = timestamp
        this.boundingBox = boundingBox
    }
}
