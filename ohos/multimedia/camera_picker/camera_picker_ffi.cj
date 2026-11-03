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

import ohos.ffi.CArrI32

foreign {
    func FfiCameraPickerPick(context: CPointer<Unit>, mediaTypes: CArrI32, pickerProfile: CPickerProfile,
        callbackId: Int64): Unit
}

@C
struct CPickerProfile {
    CPickerProfile(
        let cameraPosition: Int32,
        let saveUri: CString,
        let videoDuration: Int32
    ) {}

    func free() {
        unsafe { LibC.free(saveUri) }
    }
}

@C
struct CPickerResult {
    CPickerResult(
        let resultCode: Int32,
        let resultUri: CString,
        let mediaType: Int32
    ) {}

    func toPickerResult(): PickerResult {
        PickerResult(resultCode, resultUri.toString(), PickerMediaType.parse(mediaType))
    }
}
