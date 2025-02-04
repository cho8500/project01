create database boarddb;
use boarddb;
create table user
(
	userid varchar(50) primary key comment '아이디',
	userpw varchar(100) comment '비밀번호',
	name varchar(50) comment '이름',
	gender varchar(2) comment '성별',
	hobby varchar(2) comment '취미',
	interest varchar(50) comment '관심분야',
	retire varchar(2) default 'N' comment '탈퇴여부',
	joindate datetime default now() comment '가입일자'
);

create table board
(
	no int primary key auto_increment comment '게시물 번호',
	userid varchar(50) comment '아이디',
	title varchar(200) comment '제목',
	kind varchar(2) comment '구분',
	note text comment '내용',
	pname varchar(200) comment '물리파일명',
	fname varchar(200) comment '논리파일명',
	wdate datetime default now() comment '작성일',
	hit int default 0 comment '조회수',
	foreign key (userid) references user (userid)
);

create table reply(
	reply_no int primary key auto_increment comment '댓글 번호',
	no int comment '게시물 번호',
	rnote text comment '댓글 내용',
	rdate timestamp default now() comment '댓글 작성일',
	userid varchar(50) comment '아이디',
	foreign key (userid) references user (userid),
	foreign key (no) references board (no)
);