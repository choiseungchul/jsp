package kr.co.zadusoft.contents.dao;

class Exam2 {
	public static void main(String[] args) {
		System.out.println("합 = " + Exam2.sum(args));//호출
	}
	
	//위의 제시한 결과가 나오도록 sum메소드 작성하시오
	
	private static int sum(String[] arg){

		int a = Integer.parseInt(arg[0]);
		int b = Integer.parseInt(arg[1]);
		int c = Integer.parseInt(arg[2]);

		return a + b + c;
	}
}
