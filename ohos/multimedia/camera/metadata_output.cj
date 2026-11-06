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
import ohos.business_exception.{BusinessException, AsyncCallback}
import ohos.callback_invoke.{Callback0Argument, Callback1Argument, CallbackObject}
import ohos.ffi.{RemoteDataLite, releaseFFIData, Callback1Param, SUCCESS_CODE}
import std.collection.ArrayList
import std.sync.Mutex

/**
 * MetadataOutput implements metadata streams. It inherits from **CameraOutput**.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Multimedia.Camera.Core"
]
public class MetadataOutput <: CameraOutput {
    private let metadataOutputImpl: MetadataOutputImpl

    init(id: Int64) {
        metadataOutputImpl = MetadataOutputImpl(id)
    }

    func getID(): Int64 {
        metadataOutputImpl.getId()
    }

    /**
     * Starts to output metadata. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the metadata output starts
     *     successfully, **err** is **undefined**; otherwise, **err** is an error object with an error code defined in
     *     **CameraErrorCode**.
     * @throws { BusinessException } 7400103 - Session not config.
     * @throws { BusinessException } 7400201 - Camera service fatal error.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core",
        throwexception: true
    ]
    public func start(callback: AsyncCallback<Unit>): Unit {
        let errCode = unsafe { FfiCameraMetadataOutputStart(metadataOutputImpl.getId()) }
        spawn {
            if (errCode == SUCCESS_CODE) {
                callback(None, Some(()))
            } else {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
            }
        }
    }

    /**
     * Stops outputting metadata. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the metadata output stops
     *     successfully, **err** is **undefined**; otherwise, **err** is an error object.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func stop(callback: AsyncCallback<Unit>): Unit {
        let errCode = unsafe { FfiCameraMetadataOutputStop(metadataOutputImpl.getId()) }
        spawn {
            if (errCode == SUCCESS_CODE) {
                callback(None, Some(()))
            } else {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
            }
        }
    }

    /**
     * Releases output resources.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func release(): Unit {
        let errCode = unsafe { FfiCameraMetadataOutputRelease(metadataOutputImpl.getId()) }
        successOrThrow(errCode)
    }

    /**
     * Subscribes to metadata objects available event callback.
     *
     * @param { Callback1Argument<Array<MetadataObject>> } callback - Callback used to get the available metadata
     *     objects.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func onMetadataObjectsAvailable(callback: Callback1Argument<Array<MetadataObject>>): Unit {
        synchronized(metadataOutputImpl.metadataObjectsAvailableMutex) {
            let callbackList = metadataOutputImpl.metadataObjectsAvailableList
            if (findCallbackObject(callbackList, callback)) {
                return
            }
            let wrapper = {value: CArrCMetadataObject => dispatchMetadataObjects(value, callback)}
            let lambdaData = Callback1Param<CArrCMetadataObject, Unit>(wrapper)
            let errCode = unsafe {
                FfiCameraMetadataOutputOnMetadataObjectsAvailableV2(metadataOutputImpl.getId(), lambdaData.getID())
            }
            successOrThrow(errCode)
            callbackList.add((callback, lambdaData.getID()))
        }
    }

    /**
     * Unsubscribes from metadata objects available event callback.
     *
     * @param { ?Callback1Argument<Array<MetadataObject>> } [callback] - Callback used to get the available metadata
     *     objects. If this parameter is not specified, all **onMetadataObjectsAvailable** callbacks are
     *     unsubscribed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func offMetadataObjectsAvailable(callback!: ?Callback1Argument<Array<MetadataObject>> = None): Unit {
        synchronized(metadataOutputImpl.metadataObjectsAvailableMutex) {
            if (let Some(cb) <- callback) {
                removeMetadataObjectsAvailableCallback(cb)
            } else {
                let errCode = unsafe { FfiCameraMetadataOutputOffAllMetadataObjectsAvailable(metadataOutputImpl.getId()) }
                successOrThrow(errCode)
                metadataOutputImpl.metadataObjectsAvailableList.clear()
            }
        }
    }

    private func removeMetadataObjectsAvailableCallback(callback: CallbackObject): Unit {
        for (idx in 0..metadataOutputImpl.metadataObjectsAvailableList.size) {
            let item = metadataOutputImpl.metadataObjectsAvailableList[idx]
            if (refEq(callback, item[0])) {
                let errCode = unsafe {
                    FfiCameraMetadataOutputOffMetadataObjectsAvailable(metadataOutputImpl.getId(), item[1])
                }
                successOrThrow(errCode)
                metadataOutputImpl.metadataObjectsAvailableList.remove(at: idx)
                return
            }
        }
    }

    /**
     * Subscribes to error events.
     *
     * @param { Callback0Argument } callback - Callback used to get the metadata output errors.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func onError(callback: Callback0Argument): Unit {
        synchronized(metadataOutputImpl.errorMutex) {
            let callbackList = metadataOutputImpl.errorList
            if (findCallbackObject(callbackList, callback)) {
                return
            }
            let wrapper = { value: Int32 =>
                if (value == SUCCESS_CODE) {
                    callback.invoke(None)
                } else {
                    callback.invoke(BusinessException(value, getErrorMsg(value)))
                }
            }
            let lambdaData = Callback1Param<Int32, Unit>(wrapper)
            let errCode = unsafe { FfiCameraMetadataOutputOnError(metadataOutputImpl.getId(), lambdaData.getID()) }
            successOrThrow(errCode)
            callbackList.add((callback, lambdaData.getID()))
        }
    }

    /**
     * Unsubscribes from error events.
     *
     * @param { ?Callback0Argument } [callback] - Callback used to get the metadata output errors. If this parameter
     *     is not specified, all **onError** callbacks are unsubscribed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Multimedia.Camera.Core"
    ]
    public func offError(callback!: ?Callback0Argument = None): Unit {
        synchronized(metadataOutputImpl.errorMutex) {
            if (let Some(cb) <- callback) {
                removeErrorCallback(cb)
            } else {
                let errCode = unsafe { FfiCameraMetadataOutputOffAllError(metadataOutputImpl.getId()) }
                successOrThrow(errCode)
                metadataOutputImpl.errorList.clear()
            }
        }
    }

    private func removeErrorCallback(callback: CallbackObject): Unit {
        for (idx in 0..metadataOutputImpl.errorList.size) {
            let item = metadataOutputImpl.errorList[idx]
            if (refEq(callback, item[0])) {
                let errCode = unsafe { FfiCameraMetadataOutputOffError(metadataOutputImpl.getId(), item[1]) }
                successOrThrow(errCode)
                metadataOutputImpl.errorList.remove(at: idx)
                return
            }
        }
    }

    private func dispatchMetadataObjects(value: CArrCMetadataObject,
        callback: Callback1Argument<Array<MetadataObject>>): Unit {
        // Trigger the callback only when face detection objects exist after filtering.
        let faceObjects = value.toArray()
        if (faceObjects.size != 0) {
            callback.invoke(None, faceObjects)
        }
    }
}

class MetadataOutputImpl <: RemoteDataLite {
    let metadataObjectsAvailableList = ArrayList<(CallbackObject, Int64)>()
    let metadataObjectsAvailableMutex = Mutex()
    let errorList = ArrayList<(CallbackObject, Int64)>()
    let errorMutex = Mutex()

    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    func getId(): Int64 {
        getID()
    }
}
