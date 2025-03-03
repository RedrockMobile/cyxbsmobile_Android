package com.cyxbs.pages.mine.util.widget

import io.reactivex.rxjava3.core.Observer
import io.reactivex.rxjava3.disposables.Disposable


/**
 * [ExecuteOnceObserver] is used to only get one [onNext] Result.
 *
 * @param onExecuteOnceNext The concrete implement of the [onNext]
 * @param onExecuteOnceComplete The concrete implement of the [onComplete]
 * @param onExecuteOnceError The concrete implement of the [onError]
 * @param onExecuteOnFinal When everything is done,[onExecuteOnFinal] is called
 *
 * Created by anriku on 2018/9/18.
 */
class ExecuteOnceObserver<T:Any>(val onExecuteOnceNext: (T) -> Unit = {},
                             val onExecuteOnceComplete: () -> Unit = {},
                             val onExecuteOnceError: (Throwable) -> Unit = {},
                             val onExecuteOnFinal:()->Unit={}) : Observer<T> {

    private var mDisposable: Disposable? = null

    override fun onComplete() {
        onExecuteOnceComplete()
    }

    override fun onSubscribe(d: Disposable) {
        mDisposable = d
    }

    override fun onNext(t: T) {
        try {
            onExecuteOnceNext(t)
            this.onComplete()
        } catch (e: Throwable) {
            this.onError(e)
        } finally {
            onExecuteOnFinal()
            if (mDisposable != null && !mDisposable!!.isDisposed) {
                mDisposable!!.dispose()
            }
        }
    }

    override fun onError(e: Throwable) {
        onExecuteOnceError(e)
    }

}