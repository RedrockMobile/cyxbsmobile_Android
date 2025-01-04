package com.cyxbs.components.utils.extensions

import io.reactivex.rxjava3.core.Maybe
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.core.Single
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.rx3.asFlow


fun <T : Any> Observable<T>.asFlow(): Flow<T> {
  return asFlow()
}

fun <T : Any> Single<T>.asFlow(): Flow<T> {
  return toObservable().asFlow()
}

fun <T : Any> Maybe<T>.asFlow(): Flow<T> {
  return toObservable().asFlow()
}
