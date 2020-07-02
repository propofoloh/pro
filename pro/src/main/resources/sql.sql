CREATE TABLE MP_BOARD(
    BNO NUMBER NOT NULL, -- 게시판 번호
    TITLE VARCHAR2(100)     NOT NULL, -- 게시판 제목
    CONTENT VARCHAR2(2000)  NOT NULL, -- 게시판 내용
    WRITER VARCHAR2(100)    NOT NULL, -- 작성자
    REGDATE DATE            DEFAULT SYSDATE, --등록일
    PRIMARY KEY(BNO)
);

drop table MP_BOARD;
drop SEQUENCE MP_BOARD_SEQ

--게시판 번호 1부터 증가
CREATE SEQUENCE MP_BOARD_SEQ
START WITH 1
INCREMENT BY 1;

select * From MP_BOARD;


INSERT INTO MP_BOARD(BNO, TITLE, CONTENT, WRITER)
VALUES(MP_BOARD_SEQ.NEXTVAL, '제목입니다', '내용입니다', '이름입니다');

SELECT * FROM MP_BOARD;

update MP_BOARD set title = '타이틀변경' where bno = 1;
select * from MP_BOARD;

delete from MP_BOARD where bno = 1;
select *from MP_BOARD


insert into mp_board(bno, title, content, writer)
select mp_board_seq.nextval, title, content, writer from mp_board;


--게시글 10개씩 출력 쿼리
select bno, title, content, writer, regdate
from ( select bno, title, content, writer, regdate, row_number() over(order by bno desc) as rNum
from MP_BOARD) mp where rNum between 1 and 10 order by bno desc;


--댓글
create table mp_reply (
    bno number not null,
    rno number not null,
    content varchar2(1000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    primary key(bno, rno)
);

alter table mp_reply add constraint mp_reply_bno foreign key(bno)
references mp_board(bno);

create sequence mp_reply_seq START WITH 1 MINVALUE 0;

--댓글 테스트
insert into mp_reply(bno, rno, content, writer)
    values(110, mp_reply_seq.nextval, '테스트댓글', '테스트 작성자');

select rno, content, writer, regdate
  from mp_reply
 where bno = 110;






