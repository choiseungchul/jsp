#include <stdio.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/un.h>
#include <unistd.h>
#include <stdlib.h>
#include <jni.h>
#include "wp_juds_Connector.h"

JNIEXPORT jint JNICALL Java_wp_juds_Connector_createSocket
  (JNIEnv *jEnv, jclass jClass, jstring socketfile){
	int sockfd;
	if((sockfd = socket(AF_UNIX, SOCK_STREAM, 0)) < 0 )printf("Error Unix domain Socket fd");
	return sockfd;
}

/*
 * Class:     wp_juds_Connector
 * Method:    connectSocket
 * Signature: ()V
 */
JNIEXPORT jint JNICALL Java_wp_juds_Connector_connectSocket
  (JNIEnv *jEnv, jclass jClass, jint sockfd , jstring input) {
	
	struct sockaddr_un server_addr;
	memset( &server_addr, 0, sizeof( server_addr));
	server_addr.sun_family = AF_UNIX;

	const char *scpath = (*jEnv)->GetStringUTFChars(jEnv, input, 0);
	printf("%s" , scpath );

	strcpy( server_addr.sun_path, scpath);

	printf("%s\n" , server_addr.sun_path);

	if( -1 == connect( sockfd, (struct sockaddr*)&server_addr, sizeof( server_addr) ) )
	{
		printf( "connection failed\n");
		return -1;
	}else return 0;

}

/*
 * Class:     wp_juds_Connector
 * Method:    write
 * Signature: (I[BI)I
 */
JNIEXPORT jint JNICALL Java_wp_juds_Connector_write
  (JNIEnv *jEnv, jclass jClass, jint sockfd, jstring input, jint len)
  {
	char buf[1024];
    const char *str = (*jEnv)->GetStringUTFChars(jEnv, input, 0);
    printf("%s", str);
	strcpy(buf, str);
	
	int send_len= write(sockfd,buf,sizeof(buf));
	if(send_len>-1){
		printf("send ok\n");
	}
  }

/*
 * Class:     wp_juds_Connector
 * Method:    readData
 * Signature: (I[BI)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_wp_juds_Connector_readData
  (JNIEnv *jEnv, jclass jClass, jint sockfd, jint len)
  {
	  char read_buf[1024];
	  memset(read_buf,0x00,sizeof(read_buf));
	  read(sockfd, read_buf,sizeof(read_buf));
	
	  return (*jEnv)->NewStringUTF(jEnv, read_buf) ;
  }

/*
 * Class:     wp_juds_Connector
 * Method:    dclose
 * Signature: (I[BI)Ljava/lang/String;
 */
JNIEXPORT jint JNICALL Java_wp_juds_Connector_dclose
  (JNIEnv *jEnv, jclass jClass, jint sockfd)
  {
	  return close(sockfd);
  }

int main(){}