//
//  ParseSectionContentsTest.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/8/20.
//

import SwiftSoup
import XCTest
@testable import SwiftyNarou

class ParseSectionContentsTest: XCTestCase {
    func testParseMetadataSelectionAll() {
        let html = """
        <div class="contents1">
            <a href="/n9669bk/" class="margin_r20">無職転生　- 異世界行ったら本気だす -</a>

            作者：
            <a href="https://mypage.syosetu.com/288399/">理不尽な孫の手</a>
            <p class="chapter_title">第１章　幼年期</p>
        </div>
        """
        
        let expectedNovelTitle = "無職転生　- 異世界行ったら本気だす -"
        let expectedWriter = "理不尽な孫の手"
        let expectedChapterTitle = "第１章　幼年期"
        
        let fragment = selectFragment(html)
        let (novelTitle, writer, chapterTitle) = Narou.parseMetadataSelection(selection: fragment)
        XCTAssertEqual(novelTitle, expectedNovelTitle)
        XCTAssertEqual(writer, expectedWriter)
        XCTAssertEqual(chapterTitle, expectedChapterTitle)
    }
    
    func testParseMetadataSelectionNoChapter() {
        let html = """
        <div class="contents1">
            <a href="/n5092gl/" class="margin_r20"> ＳＳランクパーティでパシリをさせられていた男。ボス戦で仲間に見捨てられたので、ヤケクソで敏捷を９９９９まで極振りしたら『光』になった……</a>

            作者：
            <a href="https://mypage.syosetu.com/493538/">ＬＡ軍</a>

        </div>
        """
        
        let expectedNovelTitle = "ＳＳランクパーティでパシリをさせられていた男。ボス戦で仲間に見捨てられたので、ヤケクソで敏捷を９９９９まで極振りしたら『光』になった……"
        let expectedWriter = "ＬＡ軍"
        
        let fragment = selectFragment(html)
        let (novelTitle, writer, chapterTitle) = Narou.parseMetadataSelection(selection: fragment)
        XCTAssertEqual(novelTitle, expectedNovelTitle)
        XCTAssertEqual(writer, expectedWriter)
        XCTAssertNil(chapterTitle)
    }
    
    func testParsePrevAndNextButtonsBoth() {
        let html = """
        <div class="novel_bn">
            <a href="/n5092gl/17/">&lt;&lt;&nbsp;前へ</a>
            <a href="/n5092gl/19/">次へ&nbsp;&gt;&gt;</a>
        </div>
        """
        
        let expectedPrev = "n5092gl/17"
        let expectedNext = "n5092gl/19"
        
        let fragment = selectFragment(html)
        let (prev, next) = Narou.parsePrevAndNextButtons(selection: fragment)
        XCTAssertEqual(prev, expectedPrev)
        XCTAssertEqual(next, expectedNext)
    }
    
    func testParsePrevAndNextButtonsNoPrev() {
        let html = """
        <div class="novel_bn">
            <a href="/n5092gl/2/">次へ&nbsp;&gt;&gt;</a>
        </div>
        """
        
        let expectedNext = "n5092gl/2"
        
        let fragment = selectFragment(html)
        let (prev, next) = Narou.parsePrevAndNextButtons(selection: fragment)
        XCTAssertNil(prev)
        XCTAssertEqual(next, expectedNext)
    }
    
    func testParsePrevAndNextButtonsNoNext() {
        let html = """
        <div class="novel_bn">
            <a href="/n5092gl/1/">&lt;&lt;&nbsp;前へ</a>
        </div>
        """
        
        let expectedPrev = "n5092gl/1"
        
        let fragment = selectFragment(html)
        let (prev, next) = Narou.parsePrevAndNextButtons(selection: fragment)
        XCTAssertEqual(prev, expectedPrev)
        XCTAssertNil(next)
    }

    func testParseSectionBodyBasic() {
        let html = """
        <div id="novel_honbun" class="novel_view">
            <p id="L1">「な、なんじゃこりゃぁぁあああああああ！！」</p>
            <p id="L2">「きゃぁ！！」</p>
            <p id="L3">
                <br/>
            </p>
        </div>
        """

        let expectedContent = """
        「な、なんじゃこりゃぁぁあああああああ！！」
        「きゃぁ！！」
        """

        let expectedFormat = [NSRange: String]()

        let fragment = selectFragment(html)
        let body = Narou.parseSectionBody(selection: fragment)
        XCTAssertEqual(body.content, expectedContent)
        XCTAssertEqual(body.format, expectedFormat)
    }

    func testParseSectionBodyLineBreak() {
        let html = """
        <div id="novel_honbun" class="novel_view">
            <p id="L230">　今、何が起こったんだ？！</p>
            <p id="L231">
                <br/>
            </p>
            <p id="L232">「なんだ、この称号は……！　なんで今？！」</p>
        </div>
        """

        let expectedContent = """
        　今、何が起こったんだ？！

        「なんだ、この称号は……！　なんで今？！」
        """

        let expectedFormat = [NSRange: String]()

        let fragment = selectFragment(html)
        let body = Narou.parseSectionBody(selection: fragment)
        XCTAssertEqual(body.content, expectedContent)
        XCTAssertEqual(body.format, expectedFormat)
    }

    func testParseSectionBodyTrimLeadingAndTrailingLineBreaks() {
        let html = """
        <div id="novel_honbun" class="novel_view">
            <p id="L383">
                <br/>
            </p>
            <p id="L384">
                <br/>
            </p>
            <p id="L385">　これは……。</p>
            <p id="L386">　この緑色の血は──────？</p>
            <p id="L387">
                <br/>
            </p>
        </div>
        """

        let expectedContent = """
        　これは……。
        　この緑色の血は──────？
        """

        let expectedFormat = [NSRange: String]()

        let fragment = selectFragment(html)
        let body = Narou.parseSectionBody(selection: fragment)
        XCTAssertEqual(body.content, expectedContent)
        XCTAssertEqual(body.format, expectedFormat)
    }

    func testParseSectionBodyJoinRuby() {
        let html = """
        <div id="novel_honbun" class="novel_view">
            <p id="L223">
                　称号「
                <ruby>
                    <rb>音速</rb>
                    <rp>(</rp>
                    <rt>スピードオブサウンド</rt>
                    <rp>)</rp>
                </ruby>
                」⇒「
                <ruby>
                    <rb>光</rb>
                    <rp>(</rp>
                    <rt>ライトニング</rt>
                    <rp>)</rp>
                </ruby>
                」（ＮＥＷ！！）
            </p>
        </div>
        """

        let expectedContent = "　称号「音速」⇒「光」（ＮＥＷ！！）"
        var expectedBases: Set<String> = ["音速", "光"]

        let fragment = selectFragment(html)
        let body = Narou.parseSectionBody(selection: fragment)

        for format in body.format {
            let baseRange = Range<String.Index>(format.key, in: body.content)!
            let base = String(body.content[baseRange])
            XCTAssertTrue(
                expectedBases.contains(base),
                "\(base) is not a base."
            )
            expectedBases.remove(base)
        }
        XCTAssertTrue(expectedBases.isEmpty)
        XCTAssertEqual(body.content, expectedContent)
    }
    
    func testParseRuby() {
        let html = """
        <ruby>
            <rb>音速</rb>
            <rp>(</rp>
            <rt>スピードオブサウンド</rt>
            <rp>)</rp>
        </ruby>
        """
        
        let expectedBase = "音速"
        let expectedFurigana = "スピードオブサウンド"
        
        let fragment = selectFragment(html)
        let (base, furigana) = Narou.parseRuby(selection: fragment)
        
        XCTAssertEqual(base, expectedBase)
        XCTAssertEqual(furigana, expectedFurigana)
    }
    
    func testFilterSectionDataHtml() {
        let html = """
        <div class="contents1">
            <a href="/n5092gl/" class="margin_r20"> ＳＳランクパーティでパシリをさせられていた男。ボス戦で仲間に見捨てられたので、ヤケクソで敏捷を９９９９まで極振りしたら『光』になった……</a>

            作者：
            <a href="https://mypage.syosetu.com/493538/">ＬＡ軍</a>

        </div>

        <div id="novel_contents">
            <div id="novel_color">

                <div class="novel_bn">
                    <a href="/n5092gl/17/">&lt;&lt;&nbsp;前へ</a>
                    <a href="/n5092gl/19/">次へ&nbsp;&gt;&gt;</a>
                </div>
                <!--novel_bn-->

                <div id="novel_no">18/92</div>

                <p class="novel_subtitle">第１６話「ライトニング！　これがライトニングパンチだッ」</p>

                <div id="novel_honbun" class="novel_view">
                    <p id="L58">
                        <br/>
                    </p>
                    <p id="L59">
                        <br/>
                    </p>
                    <p id="L60">名　前：グエン・タック</p>
                    <p id="L61">職　業：斥候</p>
                    <p id="L62">
                        称　号：
                        <ruby>
                            <rb>音速</rb>
                            <rp>(</rp>
                            <rt>スピードオブサウンド</rt>
                            <rp>)</rp>
                        </ruby>
                        →
                        <ruby>
                            <rb>光</rb>
                            <rp>(</rp>
                            <rt>ライトニング</rt>
                            <rp>)</rp>
                        </ruby>
                        （ＮＥＷ！！）
                    </p>
                    <p id="L63">（条件：敏捷９９９９を突破し、さらに速度を求める）</p>
                    <p id="L64">
                        <br/>
                    </p>
                </div>
            </div>
        </div>
        """
        
        let expectedSectionTitle = "第１６話「ライトニング！　これがライトニングパンチだッ」"
        let expectedChapterTitle: String? = nil
        let expectedNovelTitle = """
        ＳＳランクパーティでパシリをさせられていた男。ボス戦で仲間に見捨てられたので、ヤケクソで敏捷を９９９９まで極振りしたら『光』になった……
        """
        let expectedWriter = "ＬＡ軍"
        let expectedContent = """
        名　前：グエン・タック
        職　業：斥候
        称　号：音速→光（ＮＥＷ！！）
        （条件：敏捷９９９９を突破し、さらに速度を求める）
        """
        let expectedPrevNcode = "n5092gl/17"
        let expectedNextNcode = "n5092gl/19"
        let expectedProgress = "18/92"
        var expectedBases: Set<String> = ["音速", "光"]
    
        let res = Narou.filterSectionDataHtml(
            html: try! (
                try! SwiftSoup.parseBodyFragment(html)
            ).outerHtml()
        )!
        
        for format in res.format {
            let baseRange = Range<String.Index>(format.key, in: res.content)!
            let base = String(res.content[baseRange])
            XCTAssertTrue(
                expectedBases.contains(base),
                "\(base) is not a base."
            )
            expectedBases.remove(base)
        }
        
        XCTAssertEqual(expectedSectionTitle, res.sectionTitle)
        XCTAssertEqual(expectedChapterTitle, res.chapterTitle)
        XCTAssertEqual(expectedNovelTitle, res.novelTitle)
        XCTAssertEqual(expectedWriter, res.writer)
        XCTAssertEqual(expectedContent, res.content)
        XCTAssertEqual(expectedPrevNcode, res.prevNcode)
        XCTAssertEqual(expectedNextNcode, res.nextNcode)
        XCTAssertEqual(expectedProgress, res.progress)
        XCTAssertNil(res.chapterTitle)
    }
}
