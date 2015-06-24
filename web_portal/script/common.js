
/**
 * 브라우저 주소창의 정보를 경고창으로 표시
 */
function info() {
    
    var str = "";

    str += "호스트 : " + location.host + "\n";
    str += "호스트 이름 : " + location.hostname + "\n";
    str += "포트 번호 : " + location.port + "\n";
    str += "URL : " + location.href + "\n";
    str += "문서의 경로 : " + location.pathname + "\n";
    str += "프로토콜 : " + location.protocol + "\n";
    str += "쿼리 : " + location.search + "\n";

    alert(str);
}

/**
 * 해당 URL 로 params 데이터를 요청하여 bodyContent 전역변수에 
 * 저장한다
 * @param req_url		요청을 보낼 URL
 * @param params		보낼 JSON 형태의 데이터 
 */
function callCmd(req_url,params)
{
	var bodyContent = $.ajax({
	      url: req_url,
	      global: false,
	      type: "POST",
	      data: params,
	      dataType: "html",
	      async:false,
	      success: function(){
	          
	      }
	   }
	).responseText;
	
	return bodyContent;
}


