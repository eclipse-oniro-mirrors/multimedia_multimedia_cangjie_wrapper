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

import ohos.app.ability.ui_ability.{UIAbilityContext, getStageContext}
import ohos.business_exception.AsyncCallback
import ohos.ffi.{CArrI32, Callback1Param}
import ohos.labels.APILevel

/**
 * Starts the camera picker and enters the corresponding mode based on the media type. This API uses an asynchronous
 * callback to return the result.
 *
 * **NOTE**
 *
 * When an application is running on a widescreen foldable device and the camera picker is launched while the device is
 * unfolded, switching the device from unfolded to folded will automatically move the camera picker to the background.
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
    var mediaTypesHead = CPointer<Int32>()
    if (mediaTypes.size != 0) {
        mediaTypesHead = unsafe { LibC.malloc<Int32>(count: Int64(mediaTypes.size)) }
        for (i in 0..mediaTypes.size) {
            unsafe { mediaTypesHead.write(i, mediaTypes[i].getValue()) }
        }
    }
    let cMediaTypes = CArrI32(mediaTypesHead, mediaTypes.size)
    let cSaveUri = unsafe { LibC.mallocCString(pickerProfile.saveUri ?? "") }
    let wrapper = {value: CPickerResult => callback(None, Some(value.toPickerResult()))}
    let lambdaData = Callback1Param<CPickerResult, Unit>(wrapper)
    let cPickerProfile = CPickerProfile(pickerProfile.getCameraPositionValue(), cSaveUri,
        pickerProfile.videoDuration.getOrDefault({ => 0 }))
    unsafe { FfiCameraPickerPick(getStageContext(context), cMediaTypes, cPickerProfile, lambdaData.getID()) }
    unsafe { LibC.free(mediaTypesHead) }
    cPickerProfile.free()
}
