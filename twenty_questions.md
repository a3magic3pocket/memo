- 스무고개(Twenty questions) dapp 기획
    - 가정
        - erc20 토큰
            - 스무고개는 스무고개 토큰(TQT)를 사용한다.
        - erc721 토큰
            - 스무고개는 스무고개 NFT(TQNFT)를 사용한다.
    - 우선순위
        - tier로 표시하며 숫자가 낮을 수록 우선순위가 높다.
    - 애플리케이션 개요
        - TQT 획득 로직
            - tier 1
            - 게임 로직
                - 사용자 별로 정답숫자가 할당된다.
                - 사용자는 정답숫자를 모르며,  
정답숫자를 맞추기 위해 최대 질의 수(20번)까지 질의를 할 수 있다.
                - 사용자가 질의를 할때
최대 질의 수보다 작고, 그 질의가 오답이라면,
스마트컨트랙트(sc)는 
실패 status code를 내뱉고, 정답숫자가 질의숫자보다 큰지, 작은지를 리턴해준다.
                - 사용자가 질의를 할때
최대 질의 수보다 작고, 그 질의가 정답이라면,
sc는 성공 status code를 내뱉고, 사용자에게 TQT를 1개 발행한다.
                - 사용자가 질의를 할 때
최대 질의 수보다 크면
sc는 종료 status code를 내뱉는다.
이때 sc는 '하루 게임 시도 수'를 1 더하여 갱신한다.
            - 게임 가정
                - 하루에 게임은 3번 시도할 수 있다.
(0시부터 23시 59분 59.99999초까지)
        - TQNFT 획득 로직
            - 업적으로 인한 획득
                - tier 1
                - 모든 유저의 모든 게임은
전체 게임 수에 기록된다.
                - 전체 게임 수 체크 포인트마다
최초 도달자의 지갑 주소를 저장한다.
                - 최초 도달자의 지갑 주소에 따라
그에 해당하는 업적 NFT를 발행 및 할당한다.
            - 운영자 발행 NFT 구매
                - tier 2
                - 정가
                    - 운영자에서는 TQT로 구매할 수 있는 NFT를 등록한다.
                    - 유저들은 '운영자 발행 NFT 구매'를 정가를 주고 구매할 수 있다.
                - 경매
                    - 운영자에서는 TQT로 구매할 수 있는 NFT를 등록한다.
                    - 유저들은 '운영자 발행 NFT 구매'를 정가를 주고 구매할 수 있다.
            - 운영자 발행 NFT 별 댓글 기능
                - tier 2
                - 운영자가 발행한 NFT에 댓글을 다는 기능
            - 유저가 NFT 등록
                - tier 3
                - 정가
                    - 사용자는 TQT로 구매할 수 있는 NFT를 등록한다.
                    - 유저들은 '사용자 발행 NFT 구매'를 정가를 주고 구매할 수 있다.
                    - 운영자에게 판매 대금의 10% 수수료가 돌아간다.
                - 경매
                    - 사용자는 TQT로 구매할 수 있는 NFT를 등록한다.
                    - 유저들은 '운영자 발행 NFT 구매'를 경매를 주고 구매할 수 있다.
                    - 운영자에게 판매 대금의 10% 수수료가 돌아간다.
                - 신고 기능
                    - 유저가 부적절한 NFT라고 신고 가능
                - 숨기기 기능
                    - 신고 수가 많아지면 숨기기 기능 구현
            - 유저 발행 NFT의 좋아요 기능
                - tier 4
                - 유저가 발행한 NFT에 좋아요를 넣는 기능
            - 운영자 발행 NFT 증여
                - tier 4
                - ERC721Votes 기능을 통해
NFT 별 행사권을 주고
본인이 아닌 다른 사람에게 투표하여
최다 투표자에게 이 NFT를 증여하는 기능
