/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class wp_juds_Connector */

#ifndef _Included_wp_juds_Connector
#define _Included_wp_juds_Connector
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     wp_juds_Connector
 * Method:    createSocket
 * Signature: (Ljava/lang/String;)I
 */
JNIEXPORT jint JNICALL Java_wp_juds_Connector_createSocket
  (JNIEnv *, jclass, jstring);

/*
 * Class:     wp_juds_Connector
 * Method:    connectSocket
 * Signature: ()V
 */
JNIEXPORT jint JNICALL Java_wp_juds_Connector_connectSocket
  (JNIEnv *, jclass, jint , jstring);

/*
 * Class:     wp_juds_Connector
 * Method:    write
 * Signature: (I[BI)I
 */
JNIEXPORT jint JNICALL Java_wp_juds_Connector_write
  (JNIEnv *, jclass, jint, jstring, jint);

/*
 * Class:     wp_juds_Connector
 * Method:    readData
 * Signature: (I[BI)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_wp_juds_Connector_readData
  (JNIEnv *, jclass, jint, jint);

/*
 * Class:     wp_juds_Connector
 * Method:    dclose
 * Signature: (I[BI)Ljava/lang/String;
 */
JNIEXPORT jint JNICALL Java_wp_juds_Connector_dclose
  (JNIEnv *, jclass, jint);

#ifdef __cplusplus
}
#endif
#endif
