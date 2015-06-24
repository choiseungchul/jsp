var Browser = {
	a : navigator.userAgent.toLowerCase()
}

Browser = {
	ie : /* @cc_on true || @ */false,
	ie6 : Browser.a.indexOf('msie 6') != -1,
	ie7 : Browser.a.indexOf('msie 7') != -1,
	ie8 : Browser.a.indexOf('msie 8') != -1,
	ie9 : Browser.a.indexOf('msie 9') != -1,
	opera : !!window.opera,
	safari : Browser.a.indexOf('safari') != -1,
	safari3 : Browser.a.indexOf('applewebkit/5') != -1,
	mac : Browser.a.indexOf('mac') != -1,
	chrome : Browser.a.indexOf('chrome') != -1,
	firefox : Browser.a.indexOf('firefox') != -1
}

function setCookie(name, value)
{
	var MinMilli = 1000 * 60;
	var HrMilli = MinMilli * 60;
	var DyMilli = HrMilli * 24;
	var year10 = DyMilli * 365 * 10;

	// 10년뒤로 조정
	var a10yearAfter = new Date();
	a10yearAfter.setTime(Math.round(a10yearAfter.getTime()/DyMilli + 1) * year10);
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + a10yearAfter.toGMTString() + ";"
}


function getCookie(name) {
	var Found = false
	var start, end
	var i = 0

	while(i <= document.cookie.length) {
		start = i
		end = start + name.length

		if(document.cookie.substring(start, end) == name) {
			Found = true
			break;
		}
		i++ 
	}

	if(Found == true) {
		start = end + 1
		end = document.cookie.indexOf(";", start)
		if(end < start)
		end = document.cookie.length
		return document.cookie.substring(start, end)
	}
	return ""
} 


function formatCurrency(num) {
	num = num.toString().replace(/\\|\,/g,'');
	if(isNaN(num))
		num = "0";
		sign = (num == (num = Math.abs(num)));
		//num = Math.floor(num*100+0.50B151B0001);
		num = Math.floor(num*100+0.50000000001);

		num = Math.floor(num/100).toString();

	for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
		num = num.substring(0,num.length-(4*i+3))+','+
		num.substring(num.length-(4*i+3));
		return (((sign)?'':'-') + num);
}

function alert_not_ready(){
	alert('준비 중 입니다.');
}

