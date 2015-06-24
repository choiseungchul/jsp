/*
 * jQuery File Upload Plugin JS Example 8.9.0
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/* global $, window */

$(function () {
    'use strict'; 

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
//        url: 'server/php/'
       	url: '___/file/upload',
        maxFileSize: upload_info.maxFileSize, // 10 MB
        maxNumberOfFiles : upload_info.maxNumberOfFiles, // 10 file count
        previewMaxWidth: 100,
        previewMaxHeight: 100,
        previewCrop: false
    }).bind('fileuploadadd', function (e, data) {
    	var datas = data.files[0].name.split('.');
    	var fileType = datas[datas.length-1].toLowerCase();
    	console.log( fileType);
    	if( upload_info.acceptFileTypes && upload_info.acceptFileTypes.indexOf( fileType) < 0){
            alert('해당 파일 유형은 사용할 수 없습니다.');
            return false;
        }else if( upload_info.maxFileSize < data.files[0].size){
        	alert('파일 용량이 너무 큽니다.');
        	return false;
        }
    }).bind('fileuploadstart', function (e) {
    	upload_info.init();
    }).bind('fileuploadstop', function (e) {
    	if( upload_info.failCount == 0){
    		// submit form
    		var file_info = ''; 
    		for( var i=0 ; i<upload_info.uploadedFiles.length; i++){
    			file_info += JSON.stringify( upload_info.uploadedFiles[i]) + ",";
    		}
    		$(':hidden[name=file_infos]').val( "[" + file_info + "]");
    		dynamic.util.submitForm('form');
    	}
    }).bind('fileuploadfail', function (e, data) {
    	upload_info.failCount++;
    }).bind('fileuploaddone', function (e, data) {
    	upload_info.uploadedFiles.push( data.result.files[0]);
    }).bind('fileuploadsubmit', function (e, data) {
    	console.log( 'fileuploadsubmit11 : ' + upload_info);
        data.formData = upload_info.getFormData();
        console.log( 'fileuploadsubmit : ' + data.formData);
    });

    // Enable iframe cross-domain access via redirect option:
    $('#fileupload').fileupload(
        'option',
        'redirect',
        window.location.href.replace(
            /\/[^\/]*$/,
            '/cors/result.html?%s'
        )
    );

    // Load existing files:
    $('#fileupload').addClass('fileupload-processing');
    $.ajax({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: $('#fileupload').fileupload('option', 'url'),
        dataType: 'json',
        context: $('#fileupload')[0]
    }).always(function () {
        $(this).removeClass('fileupload-processing');
    }).done(function (result) {
        $(this).fileupload('option', 'done')
            .call(this, $.Event('done'), {result: result});
    });
});
