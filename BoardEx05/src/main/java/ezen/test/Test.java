package ezen.test;

import ezen.dto.BoardDTO;
import ezen.dto.UserDTO;
import ezen.vo.BoardVO;
import ezen.vo.UserVO;

public class Test 
{
	public static void main(String[] args) 
	{
		BoardVO vo = new BoardVO();
		
		vo.setUserid("hong");
		vo.setKind("H");
		
		BoardDTO dto = new BoardDTO();
		
		for(int i = 1; i < 799; i++)
		{
			String title = String.format("[%03d] 번째 제목입니니다", i);
			String note  = String.format("[%03d] 번째 내용입니니다", i);
			
			vo.setTitle(title);
			vo.setNote(note);
			
			dto.Insert(vo);
		}
	}
}
