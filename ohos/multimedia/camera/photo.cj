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
import ohos.business_exception.{BusinessException, ERR_PARAMETER_ERROR}
import ohos.multimedia.image

/**
 * Photo defines a full-quality image object.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class Photo {
    private let photoImpl: PhotoImpl

    init(mainImage: image.Image) {
        photoImpl = PhotoImpl(ImageType.ImageValue(mainImage))
    }

    /**
     * Full-quality image.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public mut prop mainImage: ImageType {
        get() {
            photoImpl.mainImage
        }
        set(v) {
            photoImpl.mainImage = v
        }
    }
}

class PhotoImpl {
    var mainImage: ImageType

    init(mainImage: ImageType) {
        this.mainImage = mainImage
    }
}

/**
 * Defines the image container type, which is used to obtain full-quality images or uncompressed images (YUV).
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public enum ImageType {
    /**
     * Image container type that obtains full-quality images.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    ImageValue(image.Image)
    | ...
}

extend ImageType <: ToString {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func toString(): String {
        match (this) {
            case ImageValue(_) => "ImageValue"
            case _ => throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
        }
    }
}

extend ImageType <: Equatable<ImageType> {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public operator func ==(other: ImageType): Bool {
        match ((this, other)) {
            case (ImageValue(thisValue), ImageValue(otherValue)) => refEq(thisValue, otherValue)
            case _ => false
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public operator func !=(other: ImageType): Bool {
        !(this == other)
    }
}
