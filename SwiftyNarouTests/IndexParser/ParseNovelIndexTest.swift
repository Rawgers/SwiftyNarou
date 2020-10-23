//
//  SwiftyNarouTests.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/2/20.
//

import SwiftSoup
import XCTest
@testable import SwiftyNarou

class SwiftyNarouTests: XCTestCase {
    func testParseSeriesInfo() {
        let html = """
        <p class="series_title">
            <a href="/s5750d/">六面世界の物語</a>
        </p>
        """
        
        let expectedTitle = "六面世界の物語"
        let expectedNcode = "s5750d"
        
        let fragment = selectFragment(html)
        let (title, ncode) = Narou.parseSeriesInfo(selection: fragment)
        XCTAssertEqual(title, expectedTitle)
        XCTAssertEqual(ncode, expectedNcode)
    }
    
    func testParseNovelTitle() {
        let html = "<p class=\"novel_title\">無職転生　- 蛇足編 -</p>"
        let expected = "無職転生　- 蛇足編 -"
        
        let fragment = selectFragment(html)
        let title = Narou.parseNovelTitle(selection: fragment)
        XCTAssertEqual(title, expected)
    }
    
    func testParseSynopsis() {
        let html = """
        <div id="novel_ex">
            　『無職転生-異世界行ったら本気出す-』の番外編。
            <br/>

            　ビヘイリル王国での戦いに勝利したルーデウス・グレイラット。
            <br/>

            　彼はこの先なにを思い、なにを為すのか……。
            <br/>
            <br/>

            ※本編を読んでいない方への配慮を考えて書いてはおりません。興味あるけど本編を読んでいない、という方は、本編を先に読むことを強くおすすめします。
            <br/>
            <br/>

            本編はこちら：http://ncode.syosetu.com/n9669bk/
        </div>
        """
        
        let expected = """
        『無職転生-異世界行ったら本気出す-』の番外編。
        ビヘイリル王国での戦いに勝利したルーデウス・グレイラット。
        彼はこの先なにを思い、なにを為すのか……。

        ※本編を読んでいない方への配慮を考えて書いてはおりません。興味あるけど本編を読んでいない、という方は、本編を先に読むことを強くおすすめします。

        本編はこちら：http://ncode.syosetu.com/n9669bk/
        """
        
        let fragment = selectFragment(html)
        let synopsis = Narou.parseSynopsis(selection: fragment)
        XCTAssertEqual(synopsis, expected)
    }

    func testParseSectionBasic() {
        let html = """
        <dl class="novel_sublist2">
            <dd class="subtitle">
                <a href="/n4251cr/1/">１　「ノルンの嫁入り　前編」</a>
            </dd>
            <dt class="long_update">
            2015/05/19 19:00</dt>
        </dl>
        """
        
        let expected = Section(
            title: "１　「ノルンの嫁入り　前編」",
            ncode: "n4251cr/1",
            uploadTime: "2015/05/19 19:00",
            lastUpdate: nil
        )
        
        let fragment = selectFragment(html)
        let section = Narou.parseSection(selection: fragment)
        XCTAssertEqual(section, expected)
    }
    
    func testParseSectionWithUpdate() {
        let html = """
        <dl class="novel_sublist2">
            <dd class="subtitle">
                <a href="/n4251cr/2/">２　「ノルンの嫁入り　中編」</a>
            </dd>
            <dt class="long_update">

                2015/05/20 19:00
                <span title="2015/06/09 14:05 改稿">
                    （
                    <u>改</u>
                    ）
                </span>
            </dt>
        </dl>
        """
        
        let expected = Section(
            title: "２　「ノルンの嫁入り　中編」",
            ncode: "n4251cr/2",
            uploadTime: "2015/05/20 19:00",
            lastUpdate: Optional("2015/06/09 14:05")
        )
        
        let fragment = selectFragment(html)
        let section = Narou.parseSection(selection: fragment)
        XCTAssertEqual(section, expected)
    }
    
    func testParseChaptersBasic() {
        let html = """
        <div class="index_box">
            <div class="chapter_title">ウェディング・オブ・ノルン</div>

            <dl class="novel_sublist2">
                <dd class="subtitle">
                    <a href="/n4251cr/1/">１　「ノルンの嫁入り　前編」</a>
                </dd>
                <dt class="long_update">
                2015/05/19 19:00</dt>
            </dl>
            <div class="chapter_title">ルーシーとパパ</div>

            <dl class="novel_sublist2">
                <dd class="subtitle">
                    <a href="/n4251cr/4/">４　「ルーシーの入学初日　前編」</a>
                </dd>
                <dt class="long_update">

                    2015/06/24 19:00
                    <span title="2015/06/25 13:15 改稿">
                        （
                        <u>改</u>
                        ）
                    </span>
                </dt>
            </dl>
        </div>
        """
        
        let expected = [
            Chapter(
                title: "ウェディング・オブ・ノルン",
                sections: [
                    Section(
                        title: "１　「ノルンの嫁入り　前編」",
                        ncode: "n4251cr/1",
                        uploadTime: "2015/05/19 19:00",
                        lastUpdate: nil
                    )
                ]
            ),
            Chapter(
                title: "ルーシーとパパ",
                sections: [
                    Section(
                        title: "４　「ルーシーの入学初日　前編」",
                        ncode: "n4251cr/4",
                        uploadTime: "2015/06/24 19:00",
                        lastUpdate: "2015/06/25 13:15"
                    )
                ]
            )
        ]
        
        let fragment = selectFragment(html)
        let chapters = Narou.parseChapters(selection: fragment)
        XCTAssertEqual(chapters, expected)
    }
    
    func testParseNoChapters() {
        let html = """
        <div class="index_box">
            <dl class="novel_sublist2">
                <dd class="subtitle">
                    <a href="/n7812gj/4/">第1幕 【愛美(つぐみ)と愛美(まなみ)】 / 第３節</a>
                </dd>
                <dt class="long_update">
                2020/07/29 18:00</dt>
            </dl>

            <dl class="novel_sublist2">
                <dd class="subtitle">
                    <a href="/n7812gj/5/">第1幕 【愛美(つぐみ)と愛美(まなみ)】 / 第４節</a>
                </dd>
                <dt class="long_update">
                2020/08/01 18:00</dt>
            </dl>
        </div>
        """
        
        let expected = [
            Chapter(
                title: "",
                sections: [
                    Section(
                        title: "第1幕 【愛美(つぐみ)と愛美(まなみ)】 / 第３節",
                        ncode: "n7812gj/4",
                        uploadTime: "2020/07/29 18:00",
                        lastUpdate: nil
                    ),
                    Section(
                        title: "第1幕 【愛美(つぐみ)と愛美(まなみ)】 / 第４節",
                        ncode: "n7812gj/5",
                        uploadTime: "2020/08/01 18:00",
                        lastUpdate: nil
                    )
                ]
            )
        ]
        
        let fragment = selectFragment(html)
        let chapters = Narou.parseChapters(selection: fragment)
        XCTAssertEqual(chapters, expected)
    }
}
