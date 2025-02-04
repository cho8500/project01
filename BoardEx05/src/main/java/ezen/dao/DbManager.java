package ezen.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//DbManager db = new DbManager();
//db.conn = null
//db.driverLoad();
//db.dbConnect();		>	conn에 값을 대입
//db.dbDisconnect();	> 	conn을 초기화
//rs.next()	-> db.next();
//rs.getString("title");	db.getString("title");
public class DbManager {
	
	//선언은 클래스의 생성자가 호출 될 때
	//데이터베이스 연결 될 때 값이 대입
	//쿼리를 준비할 때 사용
	//자원 회수할 때 사용
	Connection conn = null;
	
	//쿼리 실행할 때 사용
	//자원 회수할 때 사용
	Statement stmt = null;
	
	//조회된 데이터가 저장되는 rs 필드
	//조회 할 때 값이 대입
	//next() 메서드를 호출하기 위해 사용
	//getString, getInt 메서드 호출하기 위해 사용
	ResultSet rs = null;
	
	//드라이버로딩
	public void driverLoad() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	//데이터베이스연결
	public void dbConnect() {
		String url = "jdbc:mysql://localhost:3306/boarddb";
		String id = "root";
		String pw = "ezen";
		try {
			conn = DriverManager.getConnection(url, id, pw);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//쿼리준비
	//쿼리실행
	//삽입, 수정, 삭제
	//execute()
	//execute("insert into memo.....")
	public void execute(String sql) {
		System.out.println(sql);
		
		//conn이 필요
		try {
			stmt = conn.createStatement();
			stmt.execute(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//조회 쿼리 실행
	//실행 결과를 rs 필드에 대입
	//executeQuery("select * from memo");
	public void executeQuery(String sql) {
		System.out.println(sql);
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//rs의 커서를 다음 행으로 이동하는 메서드
	//public static void main(String[] args){
		//Dbmanager manager = new Dbmanager();
		//manager.driverLoad();
		//manager.dbConnect();
		//manager.executeQuery("select * from memo");
		//manager.next()	-> dbmanager의 rs필드의 커서를 다음행
		//while(manager.next()){
		//	manager.getString("title");	->rs.getString();
		//}
	//}
	public boolean next() {
		try {
			boolean next = rs.next();
			return next;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	//Dbmanager에서 rs필드의 커서에 해당하는 데이터를 꺼내오는 메서드
	//rs.getString("title");
	//String data = manager.getString("title");
	public String getString(String value) {
		try {
			String data = rs.getString(value);
			return data;
		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		}
	}
	
	//rs필드의 커서에 해당하는 정수형 데이터를 꺼내오는 메서드
	public int getInt(String value) {
		try {
			int data = rs.getInt(value);
			return data;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	//자원회수
	public void dbDisconnect() {
		try {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
			
			if(conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//작은 따옴표 1개를 작은 따옴표 2개로 변환
	public String _R(String value)
	{
		return value.replace("'", "''");
	}	
}
