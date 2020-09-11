---
layout: page
title: "국민연금 데이터를 활용한 연봉추정 분석"
description: "국민연금 데이터를 활용한 연봉추정 분석 방법에 대해 알아보겠습니다."
headline: "국민연금 데이터를 활용한 연봉추정 분석 방법에 대해 알아보겠습니다."
categories: pandas
tags: [python, tensorflow, 국민연금, 연봉추정,  data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2020-09-12
---

<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="포스트-코로나-시대의-경제-상황을-국민연금-가입자-오픈데이터를-통해-알아보자?!!">포스트 코로나 시대의 경제 상황을 국민연금 가입자 오픈데이터를 통해 알아보자?!!</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>데이터셋: 공공 데이터 포털</li>
<li>형태: 파일데이터 (csv)</li>
<li>다운로드: <a href="https://www.data.go.kr/data/3046071/fileData.do">https://www.data.go.kr/data/3046071/fileData.do</a></li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">pandas</span> <span class="k">as</span> <span class="nn">pd</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">matplotlib.pyplot</span> <span class="k">as</span> <span class="nn">plt</span>
<span class="kn">import</span> <span class="nn">seaborn</span> <span class="k">as</span> <span class="nn">sns</span>
<span class="kn">import</span> <span class="nn">warnings</span>


<span class="n">warnings</span><span class="o">.</span><span class="n">filterwarnings</span><span class="p">(</span><span class="s1">'ignore'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">rc</span><span class="p">(</span><span class="s1">'font'</span><span class="p">,</span> <span class="n">family</span><span class="o">=</span><span class="s1">'NanumBarunGothic'</span><span class="p">)</span> 
<span class="n">plt</span><span class="o">.</span><span class="n">rcParams</span><span class="p">[</span><span class="s1">'figure.figsize'</span><span class="p">]</span> <span class="o">=</span> <span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">)</span>

<span class="n">pd</span><span class="o">.</span><span class="n">set_option</span><span class="p">(</span><span class="s1">'display.float_format'</span><span class="p">,</span> <span class="k">lambda</span> <span class="n">x</span><span class="p">:</span> <span class="s1">'</span><span class="si">%.2f</span><span class="s1">'</span> <span class="o">%</span> <span class="n">x</span><span class="p">)</span>

<span class="o">%</span><span class="k">matplotlib</span> inline
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_csv</span><span class="p">(</span><span class="s1">'data/national-pension-202006.csv'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>자료생성년월(자격마감일(사유발생일이 속하는 달의 다음달 15일)까지 신고분 반영)</th>
<th>사업장명</th>
<th>사업자등록번호</th>
<th>사업장가입상태코드 1:등록2:탈퇴</th>
<th>우편번호</th>
<th>사업장지번상세주소</th>
<th>사업장도로명상세주소</th>
<th>고객법정동주소코드</th>
<th>고객행정동주소코드</th>
<th>법정동주소광역시도코드</th>
<th>...</th>
<th>사업장형태구분코드 1:법인2:개인</th>
<th>사업장업종코드</th>
<th>사업장업종코드명</th>
<th>적용일자</th>
<th>재등록일자</th>
<th>탈퇴일자</th>
<th>가입자수(고지인원 수 포함)</th>
<th>당월고지금액(※ 국민연금법 시행령 제5조에 의거 기준소득월액 상한액 적용으로 실제소득과 고지금액은 상이할 수 있음 : 상한액 2019.7.~2020.6. 4860000원(2019.7.1.기준) 상한액 2020.7.~2021.6. 5030000원(2020.7.1.기준))</th>
<th>신규취득자수(납부재개 포함 : ※ 전달 고지대상자와 비교하므로 실제 취득자와 상이할 수 있음(초일취득 고지 초일이 아닌경우. 미고지(다음달 취득자수에 반영))</th>
<th>상실가입자수(납부예외 포함 : ※ 전달 고지대상자와 비교하므로 실제 퇴사자와 상이할 수 있음(초일이 아닌 상실자는 다음달 상실자수에 반영) 국민연금법 제6조 8조 동법 시행령 제18조에 의거 60세 도달하거나 퇴직연금수급자 조기노령연금 수급권을 취득한 자는 가입대상에서 제외되며 18세미만 기초수급자는 본인희망에 의해 제외될 수 있음)</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>202005.00</td>
<td>(주)니프코코리아</td>
<td>211814.00</td>
<td>1.00</td>
<td>31409.00</td>
<td>충청남도 아산시 둔포면</td>
<td>충청남도 아산시 둔포면 아산밸리남로</td>
<td>4420036032.00</td>
<td>4420036032</td>
<td>44.00</td>
<td>...</td>
<td>1.00</td>
<td>252901</td>
<td>포장용 플라스틱 성형용기 제조업</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>625.00</td>
<td>263793840.00</td>
<td>0.00</td>
<td>3.00</td>
</tr>
<tr>
<th>1</th>
<td>202005.00</td>
<td>글로웨이 주식회사</td>
<td>110812.00</td>
<td>1.00</td>
<td>6072.00</td>
<td>서울특별시 강남구 청담동</td>
<td>서울특별시 강남구 영동대로137길</td>
<td>1168010400.00</td>
<td>1168056500</td>
<td>11.00</td>
<td>...</td>
<td>1.00</td>
<td>452101</td>
<td>미장  타일 및 방수 공사업</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>3.00</td>
<td>1099960.00</td>
<td>0.00</td>
<td>0.00</td>
</tr>
<tr>
<th>2</th>
<td>202005.00</td>
<td>신일기업(주)</td>
<td>201810.00</td>
<td>1.00</td>
<td>4537.00</td>
<td>서울특별시 중구 충무로2가</td>
<td>서울특별시 중구 퇴계로</td>
<td>1114012500.00</td>
<td>1114055000</td>
<td>11.00</td>
<td>...</td>
<td>1.00</td>
<td>381002</td>
<td>NaN</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>18.00</td>
<td>5954520.00</td>
<td>0.00</td>
<td>0.00</td>
</tr>
<tr>
<th>3</th>
<td>202005.00</td>
<td>디에스디엘(주)</td>
<td>104811.00</td>
<td>1.00</td>
<td>4526.00</td>
<td>서울특별시 중구 남대문로4가</td>
<td>서울특별시 중구 세종대로</td>
<td>1114011700.00</td>
<td>1114054000</td>
<td>11.00</td>
<td>...</td>
<td>1.00</td>
<td>701201</td>
<td>비주거용 건물 임대업(점포  자기땅)</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>19.00</td>
<td>4064440.00</td>
<td>0.00</td>
<td>2.00</td>
</tr>
<tr>
<th>4</th>
<td>202005.00</td>
<td>(주)헤럴드</td>
<td>104810.00</td>
<td>1.00</td>
<td>4336.00</td>
<td>서울특별시 용산구 후암동</td>
<td>서울특별시 용산구 후암로4길</td>
<td>1117010100.00</td>
<td>1117051000</td>
<td>11.00</td>
<td>...</td>
<td>1.00</td>
<td>221200</td>
<td>잡지 및 정기 간행물 발행업</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>305.00</td>
<td>108148760.00</td>
<td>4.00</td>
<td>2.00</td>
</tr>
</tbody>
</table>
<p>5 rows × 22 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="Column-정리-(Clean)">Column 정리 (Clean)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">columns</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>Index(['자료생성년월(자격마감일(사유발생일이 속하는 달의 다음달 15일)까지 신고분 반영)', ' 사업장명', ' 사업자등록번호',
       ' 사업장가입상태코드 1:등록2:탈퇴', ' 우편번호', ' 사업장지번상세주소', ' 사업장도로명상세주소',
       ' 고객법정동주소코드', ' 고객행정동주소코드', ' 법정동주소광역시도코드', ' 법정동주소광역시시군구코드',
       ' 법정동주소광역시시군구읍면동코드', ' 사업장형태구분코드 1:법인2:개인', ' 사업장업종코드', ' 사업장업종코드명',
       ' 적용일자', ' 재등록일자', ' 탈퇴일자', ' 가입자수(고지인원 수 포함)',
       ' 당월고지금액(※ 국민연금법 시행령 제5조에 의거 기준소득월액 상한액 적용으로 실제소득과 고지금액은 상이할 수 있음 : 상한액 2019.7.~2020.6. 4860000원(2019.7.1.기준) 상한액 2020.7.~2021.6. 5030000원(2020.7.1.기준))',
       ' 신규취득자수(납부재개 포함 : ※ 전달 고지대상자와 비교하므로 실제 취득자와 상이할 수 있음(초일취득 고지 초일이 아닌경우. 미고지(다음달 취득자수에 반영))',
       ' 상실가입자수(납부예외 포함 : ※ 전달 고지대상자와 비교하므로 실제 퇴사자와 상이할 수 있음(초일이 아닌 상실자는 다음달 상실자수에 반영) 국민연금법 제6조 8조 동법 시행령 제18조에 의거 60세 도달하거나 퇴직연금수급자 조기노령연금 수급권을 취득한 자는 가입대상에서 제외되며 18세미만 기초수급자는 본인희망에 의해 제외될 수 있음)'],
      dtype='object')</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">columns</span> <span class="o">=</span> <span class="p">[</span><span class="s1">'자료생성년월'</span><span class="p">,</span> <span class="s1">'사업장명'</span><span class="p">,</span> <span class="s1">'사업자번호'</span><span class="p">,</span> <span class="s1">'가입상태'</span><span class="p">,</span> <span class="s1">'우편번호'</span><span class="p">,</span> <span class="s1">'지번주소'</span><span class="p">,</span> <span class="s1">'도로명주소'</span><span class="p">,</span> <span class="s1">'법정주소코드'</span><span class="p">,</span> 
           <span class="s1">'행정주소코드'</span><span class="p">,</span> <span class="s1">'광역시코드'</span><span class="p">,</span> <span class="s1">'시군구코드'</span><span class="p">,</span> <span class="s1">'읍면동코드'</span><span class="p">,</span> <span class="s1">'사업장형태'</span><span class="p">,</span> <span class="s1">'업종코드'</span><span class="p">,</span> <span class="s1">'업종코드명'</span><span class="p">,</span> 
           <span class="s1">'적용일'</span><span class="p">,</span> <span class="s1">'재등록일'</span><span class="p">,</span> <span class="s1">'탈퇴일'</span><span class="p">,</span> <span class="s1">'가입자수'</span><span class="p">,</span> <span class="s1">'고지금액'</span><span class="p">,</span> <span class="s1">'신규'</span><span class="p">,</span> <span class="s1">'상실'</span><span class="p">,</span>
          <span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">len</span><span class="p">(</span><span class="n">df</span><span class="o">.</span><span class="n">columns</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>22</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">len</span><span class="p">(</span><span class="n">columns</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>22</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">columns</span> <span class="o">=</span> <span class="n">columns</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>자료생성년월</th>
<th>사업장명</th>
<th>사업자번호</th>
<th>가입상태</th>
<th>우편번호</th>
<th>지번주소</th>
<th>도로명주소</th>
<th>법정주소코드</th>
<th>행정주소코드</th>
<th>광역시코드</th>
<th>...</th>
<th>사업장형태</th>
<th>업종코드</th>
<th>업종코드명</th>
<th>적용일</th>
<th>재등록일</th>
<th>탈퇴일</th>
<th>가입자수</th>
<th>고지금액</th>
<th>신규</th>
<th>상실</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>202005.00</td>
<td>(주)니프코코리아</td>
<td>211814.00</td>
<td>1.00</td>
<td>31409.00</td>
<td>충청남도 아산시 둔포면</td>
<td>충청남도 아산시 둔포면 아산밸리남로</td>
<td>4420036032.00</td>
<td>4420036032</td>
<td>44.00</td>
<td>...</td>
<td>1.00</td>
<td>252901</td>
<td>포장용 플라스틱 성형용기 제조업</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>625.00</td>
<td>263793840.00</td>
<td>0.00</td>
<td>3.00</td>
</tr>
<tr>
<th>1</th>
<td>202005.00</td>
<td>글로웨이 주식회사</td>
<td>110812.00</td>
<td>1.00</td>
<td>6072.00</td>
<td>서울특별시 강남구 청담동</td>
<td>서울특별시 강남구 영동대로137길</td>
<td>1168010400.00</td>
<td>1168056500</td>
<td>11.00</td>
<td>...</td>
<td>1.00</td>
<td>452101</td>
<td>미장  타일 및 방수 공사업</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>3.00</td>
<td>1099960.00</td>
<td>0.00</td>
<td>0.00</td>
</tr>
<tr>
<th>2</th>
<td>202005.00</td>
<td>신일기업(주)</td>
<td>201810.00</td>
<td>1.00</td>
<td>4537.00</td>
<td>서울특별시 중구 충무로2가</td>
<td>서울특별시 중구 퇴계로</td>
<td>1114012500.00</td>
<td>1114055000</td>
<td>11.00</td>
<td>...</td>
<td>1.00</td>
<td>381002</td>
<td>NaN</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>18.00</td>
<td>5954520.00</td>
<td>0.00</td>
<td>0.00</td>
</tr>
<tr>
<th>3</th>
<td>202005.00</td>
<td>디에스디엘(주)</td>
<td>104811.00</td>
<td>1.00</td>
<td>4526.00</td>
<td>서울특별시 중구 남대문로4가</td>
<td>서울특별시 중구 세종대로</td>
<td>1114011700.00</td>
<td>1114054000</td>
<td>11.00</td>
<td>...</td>
<td>1.00</td>
<td>701201</td>
<td>비주거용 건물 임대업(점포  자기땅)</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>19.00</td>
<td>4064440.00</td>
<td>0.00</td>
<td>2.00</td>
</tr>
<tr>
<th>4</th>
<td>202005.00</td>
<td>(주)헤럴드</td>
<td>104810.00</td>
<td>1.00</td>
<td>4336.00</td>
<td>서울특별시 용산구 후암동</td>
<td>서울특별시 용산구 후암로4길</td>
<td>1117010100.00</td>
<td>1117051000</td>
<td>11.00</td>
<td>...</td>
<td>1.00</td>
<td>221200</td>
<td>잡지 및 정기 간행물 발행업</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>305.00</td>
<td>108148760.00</td>
<td>4.00</td>
<td>2.00</td>
</tr>
</tbody>
</table>
<p>5 rows × 22 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="핵심-데이터-column-추출">핵심 데이터 column 추출</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span> <span class="o">=</span> <span class="n">df</span><span class="p">[[</span><span class="s1">'사업장명'</span><span class="p">,</span> <span class="s1">'가입자수'</span><span class="p">,</span> <span class="s1">'신규'</span><span class="p">,</span> <span class="s1">'상실'</span><span class="p">,</span> <span class="s1">'고지금액'</span><span class="p">]]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>사업장명</th>
<th>가입자수</th>
<th>신규</th>
<th>상실</th>
<th>고지금액</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>(주)니프코코리아</td>
<td>625.00</td>
<td>0.00</td>
<td>3.00</td>
<td>263793840.00</td>
</tr>
<tr>
<th>1</th>
<td>글로웨이 주식회사</td>
<td>3.00</td>
<td>0.00</td>
<td>0.00</td>
<td>1099960.00</td>
</tr>
<tr>
<th>2</th>
<td>신일기업(주)</td>
<td>18.00</td>
<td>0.00</td>
<td>0.00</td>
<td>5954520.00</td>
</tr>
<tr>
<th>3</th>
<td>디에스디엘(주)</td>
<td>19.00</td>
<td>0.00</td>
<td>2.00</td>
<td>4064440.00</td>
</tr>
<tr>
<th>4</th>
<td>(주)헤럴드</td>
<td>305.00</td>
<td>4.00</td>
<td>2.00</td>
<td>108148760.00</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="데이터-통계">데이터 통계</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'신규'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0.7133490952613984</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'상실'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0.6194477036128619</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'가입자수'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>19.763622177543773</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'고지금액'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>5482982.487200803</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="월급,-연봉-추정">월급, 연봉 추정</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="p">(</span><span class="n">df_main</span><span class="p">[</span><span class="s1">'고지금액'</span><span class="p">]</span> <span class="o">/</span> <span class="n">df_main</span><span class="p">[</span><span class="s1">'가입자수'</span><span class="p">])</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0   422070.14
1   366653.33
2   330806.67
3   213917.89
4   354586.10
dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'인당고지금액'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df_main</span><span class="p">[</span><span class="s1">'고지금액'</span><span class="p">]</span> <span class="o">/</span> <span class="n">df_main</span><span class="p">[</span><span class="s1">'가입자수'</span><span class="p">]</span>
<span class="n">df</span><span class="p">[</span><span class="s1">'인당고지금액'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s1">'고지금액'</span><span class="p">]</span> <span class="o">/</span> <span class="n">df</span><span class="p">[</span><span class="s1">'가입자수'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'인당고지금액'</span><span class="p">]</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0   422070.14
1   366653.33
2   330806.67
3   213917.89
4   354586.10
Name: 인당고지금액, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>국민연금 정보로 어떻게 연봉정보를 계산하나요?</strong></p>
<p>국민연금 보험률은 9%입니다. 쉽게 이야기 하면 급여(신고소득월액)의 9%를 국민연금으로 내는 것입니다.</p>
<p>하지만 이를 절반으로 나누어 <strong>4.5%는 회사가, 나머지 절반은 개인이 부담하는 구조</strong>입니다. 회사는 급여 외에 추가로 금액을 부담합니다.</p>
<p>국민연금 보험료는 <strong>소득 상한선과 하한선이 설정되어 있어 소득 전체가 아닌 일부 소득에만 부과</strong>됩니다.</p>
<p>이를 역산하면 신고소득월액의 계산이 가능합니다. 하지만 <strong>상한선과 하한선이 설정되어 있어 실제보다 과소계산</strong>될 수 있습니다</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>[수식]</p>
<ul>
<li>임직원 평균 월급 = 인당고지금액 / 9% * 100%</li>
<li>임직원 평균 연봉 = 임직원 평균 월급 * 12개월</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'평균월급'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df_main</span><span class="p">[</span><span class="s1">'인당고지금액'</span><span class="p">]</span> <span class="o">/</span> <span class="mi">9</span> <span class="o">*</span> <span class="mi">100</span>
<span class="n">df</span><span class="p">[</span><span class="s1">'평균월급'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s1">'인당고지금액'</span><span class="p">]</span> <span class="o">/</span> <span class="mi">9</span> <span class="o">*</span> <span class="mi">100</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'평균연봉'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df_main</span><span class="p">[</span><span class="s1">'평균월급'</span><span class="p">]</span> <span class="o">*</span> <span class="mi">12</span>
<span class="n">df</span><span class="p">[</span><span class="s1">'평균연봉'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s1">'평균월급'</span><span class="p">]</span> <span class="o">*</span> <span class="mi">12</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'평균월급'</span><span class="p">]</span><span class="o">.</span><span class="n">notnull</span><span class="p">()</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>486786</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>
<span class="n">sns</span><span class="o">.</span><span class="n">distplot</span><span class="p">(</span><span class="n">df_main</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">df_main</span><span class="p">[</span><span class="s1">'평균연봉'</span><span class="p">]</span><span class="o">.</span><span class="n">notnull</span><span class="p">(),</span> <span class="s1">'평균연봉'</span><span class="p">])</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'평균연봉'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">18</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>
<span class="n">sns</span><span class="o">.</span><span class="n">distplot</span><span class="p">(</span><span class="n">df_main</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">df_main</span><span class="p">[</span><span class="s1">'평균월급'</span><span class="p">]</span><span class="o">.</span><span class="n">notnull</span><span class="p">(),</span> <span class="s1">'평균월급'</span><span class="p">])</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'평균월급'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">18</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAkwAAAG+CAYAAABh1ltMAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAADl0RVh0U29mdHdhcmUAbWF0cGxvdGxpYiB2ZXJzaW9uIDIuMi4zLCBodHRwOi8vbWF0cGxvdGxpYi5vcmcvIxREBQAAIABJREFUeJzs3Xd01NeBPfD7po800qiNekcgehUIMMbguMaJ426HuBfibDa/xGmb3cTJZjfZTXazKY7juBfcE/de4kYxCESXQCBQQxr1MhqVkaa83x8StsCA2ozelPs5h4M0Gs1cH6OZq/fe9z0hpQQRERERnZ5GdQAiIiKiYMfCRERERDQKFiYiIiKiUbAwEREREY2ChYmIiIhoFCxMRERERKNgYSIiIiIaBQsTEQWMEOJXQggphDD58TGFEOJWIcRGIUSjEKJPCFEphHheCLFkxP1Mw8/97/56biKKXCxMRDRmQojM4RJypj81ozzGP4/hMY7/WXOKh/gdgIcB7ABwDYAVAP4FQC6ArUKI4gA/PxFFIJ3qAEQUUpoAzAIQBcAMoH34di2AeADdAKQQ4rzh23NP8RjvAbhhlOdZBOD7AJyn+NqdAF6UUv5gxG17hRBbhvOtA1Byhsd+F8DXR3n+JQB+iKH/HiIiFiYiGjsppQdAhRDiPwD8REppAAAhxAIAmwBcDqACwPtneIzDAA6f6XmEEL7hD09VmA4BWCqEyJdSVg3fX2BotAnDz3+m/4ZKAJWjPL9x+EPHme5HRJGDU3JENBFenPgLl374b7eUskJKKaSUAsAvJ/j4ccN/d57ia1cAaAZQKYQoE0JsBdAA4LcA/gDggQk+50jpw383+uGxiCgMcISJiCbCi6GBHY2U0ocRhUkIMRPAwUk+fhYADz6f8vuMlLIGQLEQYjaAQgCxAOwAjgCIAfBlIUQSgOcm8fyFAJqklH2TeAwiCiMsTEQ0EZ7hv3UABjGiMAGowtA6JwD4LobWHEEIYcHYX3MKMLQeKXZotg0+ABdgaMH3cRoApuE/5hGP3Y2hNUwnFCYhxDYAZ1wQfjIhhBz+sFZKmTue7yWi8MLCRERjJoRIAJAMIHH4ptlCCBeA/OHPF2NooXcRgFdw4gjRPzDOwoLPp+RqAZwP4FcjviYBfAdAGoBLAbRhaLTp+ELt2Sc91s8AJI3z+Y/rneD3EVGYYGEiovG4FcD/jvh89/DfXgA9GLq8vw1D02Mnrz/6MgDDSbddCeBeAOcB2Dt8Ww2AVwGMvArOK6VsxUmLtYUQlwOIk1J+PPz5EQDTThVcSvmPM/6XERGdAQsTEY2ZlPJ3OHFa7IyEEJeN+N6OU3z9+FVoDill2/BtANAvpWwaw1O8AWDniM+XYmiLA2Boyu4KAKUnPeccDC1G/28p5cjvHXmffAD/A+APUsotY8hBRGEuIIVJCFEI4DEAdVLK68b4PY8ByBtx01IpZXQg8hGRfwkhNABSMbQ/kxtA6/CC6UcwNBU3OOK+6QBm4Mx7JY32fFcB+PuIz39+hrv/GieWJhuGRrYeP8P3JAzf54WJZiSi8BKoEaZiAPcAuGy0Ox4npbzl+MfDV7/8dwByEZEfCSEuwdDU2UoAxpO+dgRDC69/O3wl3XGXAvgrgOmTeOp38fnC8jM509V6rw+PZhERjSog+zBJKTdg6AqXzwghooQQjwkhPhZCbBVCXH2Gh/g3AL8JRDYi8g8hxA0YmhLrAvAlDO30rcXQFWuFAP4E4NsAPhgegTqVwxjaN6llxG0PA/g4MKlPcAeGStep/lw+Bc9PRCFkKtcw/RhAhZTyFiGEGcBOIcSrUsrBkXcSQkwDkCKl3DqF2Yho/C4HMADgWimle8TtLgwVocNCiGwAPwKQA6D65AeQUm4HsP2k2743hue+ECOm5CaoXkp5yl3B/XlYMBGFh6ksTEUAkoUQFw9/fnzNQ91J9/sJhhZbElFwexVDpekJIcQfMXQkiRNDezKlY2jfpNswdPXbyT/nAHCJEKJ5DM/zvJRSnuZrx49iORPfaW7PHN5k81Ryx5CLiCLIVBamMgDlUsonAUAIkSelPOFFVAiRBWCWlPK051ARUXCQUj4xfJXbXRg6R+7kLQNqADwK4NdSSu8pHuKPY3yqF/D5Rpkne3kM398LwHKK2x8a4/MTEUGc/he3ST6wEGsA3Hn8KjkhRAyA+wFkABAAdkkp7zrpe+4B8JGUciwvgkQUJIQQWnx+lZwHQ1fJ9ahNRUTkPwErTEREREThIiBXyRERERGFE7+vYUpKSpK5ubn+flgiIiIiv9u5c2eblNI22v38Xphyc3NRWlo6+h2JiIiIFBNC1I7lfpySIyIiIhoFCxMRERHRKFiYiIiIiEbBwkREREQ0ChYmIiIiolGwMBERERGNgoWJiIiIaBSj7sMkhNAAaAWwf/gmr5TySwFNRURERBRExrJxpRXAx1LKKwMdhoiIiCgYjWVKLh7AUiHEJiHEh0KIKwIdioiIiCiYjGWEqUZKmQ0AQohMAO8KIY5IKfcdv4MQYj2A9QCQnZ0dkKBEREREqow6wiSl9I34uB7AOwDmnnSfB6WURVLKIptt1PPriIiIiELKqIVJCFEghIge/jgWwLkAtgU6GBEREVGwGMuUnA3Ao0IIANAC+E8pZVVAUxEREREFkVELk5RyK4DVU5CFiIiIKChx40oiIiKiUYxlSo6IKKCeKakb9T7rinkFLhGpw8JERFPqSEsPPqxoRlvPINqcA2jtGcCRlh64vRLZCVGYZotGvs0Cq1mvOioR0WdYmIhoSuyvd+C+j4/gnfImSAkYdRokWYxIshhgNeshhEBFUzd21XUCAJIsRkyzRWNOuhX5tmjF6Yko0rEwEVFAba/uwL0fHcHGw62IMenw7TUFuHFFDmwxRgxfffvZlJxPSjQ5XKhq7cHR1l7srutCSXUHLEYd3tjXiAWZVmQlREEz/H2nwqk7IgoEFiYiCohjHX342Stl+ORwKxKjDfjxRYW4fnkOYk2nn2rTCIH0ODPS48xYNd0Gt9eHQ01O7KvvQmlNB7ZVtSPOrMfawmQsyY0/Y3EiIvInFiYi8iuP14dHt1Tj9+8fhlYI/OySWfhGcQ7MBu24H0uv1WBuhhVzM6wYcHtxsKkbJVUdeHlPA3bWdeKyhRlItZoC8F9BRHQiFiYi8pv99Q785KV9KLd347xZKVicHYcogw4v726Y9GMb9VoszIrHgsw47Krrwttljbj3o0qsKkjCuTNTYNBxlxQiChwWJiKakJFbAbjcXnxwsBmfHm2HxaTDumXZmJMe+9kaJX8SQmBJTjxmpsbgnfImbKxsw74GB64tykJOIheHE1FgsDAR0YRJKbG3vgtv729Cz4AHS/MScOHs1AlNv41XtFGHKxdnYnF2PF7aVY9Ht1TjphW5AX9eIopMHMMmoglp6nbhoU3V+FtpPaxRenxrzTRctjBjSsrSSHlJ0Vi/Oh/xUQY8sbUGW460TenzE1FkYGEionE51tGHX7xahns/rESL04XLF2bgznOmITM+SlmmGJMet5+dj4RoA259fAc2Hm5VloWIwhOn5IhoTHbXdeLhTdV4u6wRGiFQlJOAC2anIMoYHC8jFqMOt6/Kx0u7G3D7hlI8eMMSrClMVh2LiMIER5iI6LRcbi/e2t+Iq/76KS6/71NsrGzFHavzself1uKyRRlBU5aOizbq8MztxZiebMH6DTvxYUWz6khEFCaC69WOiJQb9PiwqbIVb+xrxPsHmtEz4EFWghm/+OpsXFOUheggK0kni4824Jnbl+P6R0pw55O78MCNS7CWI01ENEnB/cpHRH41ciuAkzn63fiwohn7GxxwuX0w67WYkx6LeZlW5CdZoNUIvLrHPoVpJ84apcdTtxXjG49swzef3ImHbizCOTNsqmMRUQhjYSKKcF6fxJYjbfiwogU+KTEvw4p5mVYUJFug04TerP3IUnjZwgw8srkatz2+AzeuyEVBsgUAz5sjovFjYSKKYEdbe/D6XjtanAOYmRqDr8xPR0K0QXUsv4ky6HDrWXl4ZHM1NmytwU0rczHNZlEdi4hCUOj9+khEk+Zye/H8jjo8srkabq8PNyzPwY0rcsOqLB0XbdTh1lV5SLQYsGFrDapae1RHIqIQxMJEFGF6Bjx4eHMV9jc4cO7MZHzvvBmYlRarOlZAWYw63LZqaHPLJ7fVorLZqToSEYUYFiaiCNLVN4gHN1ah1TmAG5bn4rxZKdBrI+NlwGLU4eaVudBrNbjtiVJ09A6qjkREISQyXimJCFWtPXhwYxWcLjduXpmHwtQY1ZGmXFyUATcsz0FTtwt3PrkTAx6v6khEFCJYmIgiQLndgWse2Aq314fbz85HXlK06kjKZCVE4XdXL8D2mg7820tlkFKqjkREIYBXyRGFudKaDtzy+A7EGHW4YXUubDFG1ZGUu3RBOo629OBPH1SiINmCb62ZpjoSEQU5FiaiMPbRoRZ866mdSLea8eTtxfjkEA+lBYb2akqOMWJ+phX/804F6jv7MCfdesJ9uFcTEY3EKTmiMPXqngbc8UQpptks+NudK5ARZ1YdKagIIXDl4kxkxJvx4q569A54VEcioiDGwkQUhp7cVovvPb8Hi3Pi8ez65UiycBruVPRaDa5cnIlBjw8fVLSojkNEQYyFiSiMSClx74eVuPuVMpxbmIwNty5DrEmvOlZQS4k1oSg3Adur29HidKmOQ0RBioWJKExIKfGbtyvwu/cO4/JFGbj/hiUw6bWqY4WE4/tRvVPWpDoKEQUpFiaiMODzSfzy9QN4YGMVrl+ejf+7ekHEbEjpDxajDmtm2FDR5MRRHp1CRKfAq+SIQpzPJ/HTV/bj2e3HsKogCbNSY/HcjmOqY4WclQVJKKnuwFv7G/HttQWq4xBRkOGvoEQhzOP14Ycv7MWz249hTaENF89NhRBCdayQpNdqcMGcVDQ6XNhd16U6DhEFGRYmohDl9vrwvef34KVdDfjB+TNwwWyWpcman2lFZrwZ7x9oQt8gtxkgos9xSo4oyD1TUnfK21/e3YAdNR24eG4qErltgF9ohMAl89LwwMYqPLSxGt89b7rqSEQUJDjCRBSCDjU5saOmA6unJ+Hs6TbVccJKTmI05qTH4oGNR9HZO6g6DhEFCRYmohDTP+jFy7vrkRxjxHmzUlTHCUtfmpWCvkEvntpWqzoKEQUJFiaiEPPm/kb0DHhw1ZJM6Lh1QECkxpqwptCGJ7bWwOX2qo5DREGAr7ZEIaSisRu76jpxzgwbMuOjVMcJa+tX56OtZxAv7WpQHYWIggALE1GI6B/04uU9DUiNNWHtzGTVccLeivxEzM2IxcObquDzSdVxiEgxFiaiEPHGPjt6Bzy4ckkmdBr+6AaaEALrV09DVVsv/nGwWXUcIlKMr7pEIeCAvRu7j3VhTWEyMuLMquNEjC/PTUVmvBkPbqxSHYWIFGNhIgpygx4fXtvbgDTr0EJkmjo6rQa3rcpDaW0ndtZ2qo5DRAqxMBEFuY8Pt6Db5cGlC9I5FafANUVZsJr1eIijTEQRja++REGsrr0PmyvbsDArDjmJ0arjRKRoow7XL8/GuweaUN3WqzoOESnCwkQUxH715gFohMBFc1JVR4loN63MhV6jwcObOMpEFKlYmIiC1MbDrXjvQDPWzkxGrFmvOk5ES44x4YrFGXhhZz3aewZUxyEiBXj4LlEQcnt9+OXr5chNjMJZ0xJVx4lIJx96nBprwoDHh399aT/WFH6+D9a64uypjkZECnCEiSgIPfFpDY629uLnX53N40+CRHKsCQXJFmyraoeXG1kSRRy+EhMFmVbnAP70j0qsKbTh3Jk8XDeYrMxPRLfLg3K7Q3UUIppiLExEQeY3b1fA5fHi7q/MVh2FTjIjNQYJ0QZsPdquOgoRTTEWJqIg8uz2Ory4qx7fXD0N02wW1XHoJBohsCI/EbUdfWjo7Fcdh4imEAsTUZAoqWrH3a+U4ZwZNtx1/gzVceg0luTEw6DVYGtVm+ooRDSFWJiIgsCxjj586+ldyE6Mwj1fXwStRqiORKdh0muxOCcOe+sd6BnwqI5DRFOE2woQBcDJl6SfzrribPQMeHDHhlJ4vD48ctNSWLnnUtBbkZ+EbVUd2F7dgfWr81XHIaIpwBEmIoV8Pom7nt+DypYe/OUbi5GXxONPQoEtxogZKRaUVLfD7fWpjkNEU4CFiUihP/zjMN4/0IyfXTILZ0+3qY5D47AiPwlOlwdvlzWpjkJEU4CFiUiRIy09+POHR3BtURZuXpmrOg6N0/QUCxKjDXhsS7XqKEQ0BbiGiUiB/kEvXtxVD5vFiFlpsXh2+zHVkWicNEJgxbREvLGvEfvquzA/M051JCIKII4wESnw2t4GOF1uXF2UCYOOP4ahanF2PMx6LZ7dPrZF/kQUuvhKTTTF9tV3YW+9A2tnJiMzPkp1HJoEk16Lr8xPw2t77OjlFgNEYY2FiWgKOfrdeHWPHZnxZqyZkTz6N1DQu25ZNnoHvXh9r111FCIKIBYmoikipcRLu+rh8flwzZIsbk4ZJhZnx2FGigXP7uA6NKJwxsJENEVKqjtQ2dKDi+emISnGqDoO+YkQAtctzcbeY1042NitOg4RBQgLE9EU6Bvw4O2yRkxPtqA4L0F1HPKzKxZnwKDT4Dku/iYKWyxMRFOgsqUHbq/El2alQAhOxYWbuCgDLp6bipd2N6B/0Ks6DhEFAAsT0RSobHHCrNciM96sOgoFyHVLs+F0efDW/kbVUYgoAMa0caUY+pX4PQANUsqbA5qIKMz4pMTh5h4UJFug4ehS2Dl+0LKUEonRBtzzYSUGPCeeL7euOFtFNCLyo7GOMP0TgLJABiEKV00OF3oGPJiREqM6CgWQEAJLcxNQ296Hlm6X6jhE5GejFiYhRC6ASwD8OdBhiMJRZUsPAGB6skVxEgq0xTnx0AqB0tpO1VGIyM/OWJiGp+LuAfAdAL4z3G+9EKJUCFHa2trq54hEoe1wsxOpsSbEmvWqo1CAWYw6zEqLwa66Tni8p33JJKIQNNoI050A3pVSHj3TnaSUD0opi6SURTabzX/piELcgNuLuvY+zEjh6FKkWJqbgL5BLw5wTyaisDJaYVoKYLUQ4jkA9wM4Rwjx88DHIgoPVW298EqJ6Vy/FDGmJVtgNeuxq47TckTh5IxXyUkpbz3+sRBiDYCbpZT/EehQROHicLMTBq0GOQk8ZDdSaITAouw4fHKoFd39bk7FEoWJMe/DJKX8mFsKEI1PZUsP8m3R0Gm55VkkWZwVDwlgz7Eu1VGIyE/4Kk4UIO09A+joHeR0XARKijEiOyEKu+o6IaVUHYeI/ICFiShADjc7AQAzuJ1ARFqcHY8W5wAauvpVRyEiP2BhIgqQypYeJEQbkGgxqo5CCszLsEKnEVz8TRQmWJiIAsDj9eFoaw+3E4hgZoMWs9NjsfeYAwMeHshLFOpYmIgCoKa9D26vxIxkrl+KZIuz49Hv9uLDgy2qoxDRJLEwEQVAZYsTWiGQZ4tWHYUUKki2INakwws761VHIaJJYmEiCoDK5h7kJEXBqNOqjkIKaYTAwqx4fHy4Fa3OAdVxiGgSWJiI/Ky524Wmbhen4wgAsDg7Dl6fxKt7GlRHIaJJYGEi8rPddUObFeYlcTqOgORYExZkxeGFnfXck4kohLEwEflZRVM3BICUWJPqKBQkrlqSiYomJ8rtPJCXKFSxMBH52cHGbiRaDDDo+ONFQy6dnw6DVsPF30QhjK/oRH5W0eREqtWsOgYFEWuUHhfOTcXLuxvgcnNPJqJQxMJE5Ee9Ax7UtvchldNxdJJri7Lg6HfjvQPNqqMQ0QSwMBH50aHh8+PSrCxMdKKV0xKRGW/G8zvqVEchoglgYSLyo4ONQ4t6OcJEJ9NoBK5ekoUtR9pxrKNPdRwiGicWJiI/qmh0IsaoQ1yUXnUUCkJXF2VCCODvpcdURyGicWJhIvKjiqZuzEyLgRBCdRQKQulxZqyebsPfd9bD6+OeTEShhIWJyE+klKhodGJmaqzqKBTErl2ahUaHCxsrW1VHIaJxYGEi8pP6zn44BzyYlcbCRKd33qwUJEQb8LcdnJYjCiUsTER+UtE0dIXczDSeIUenZ9BpcMWiDLx/oBltPTyQlyhU6FQHIAoXx6+QK0yJQUWjU3EaCibPlJy4lUC0UQePT+LuV8pw9nTbZ7evK86e6mhENEYcYSLyk4qmbuQkRiHayN9D6MxSYk3ITohCaW0nD+QlChEsTER+UtHoxCwu+KYxKsqJR6tzAHXck4koJLAwEflB/6AX1e29XL9EYzYv0wqDVoPSmk7VUYhoDFiYiPzgULMTUoJbCtCYGXVaLMiyYl9DF/oHeSAvUbBjYSLyg4rhBd+zuaUAjcOy3ES4vRJ7jnGUiSjYsTAR+UFFkxPRBi0y482qo1AIyYg3IyPOjO01HVz8TRTkWJiI/OBAYzcKU2Og0fBIFBqfZbkJaO7m4m+iYMfCRDRJQ0eidHOHb5qQ+VlWGHUabK/uUB2FiM6AhYlokhodLnS7PJjJwkQTYNRpsTArDvsbHOjqG1Qdh4hOg4WJaJKO7/A9K5VbCtDELMtLgMcn8eKuBtVRiOg0WJiIJun4GXKFLEw0QWlWM7LizXimpJaLv4mCFAsT0SQdbOxGVoIZMSa96igUwpblJeJoay9KuJaJKCixMBFN0sHGbm5YSZM2L8OKGJPuCwf1ElFwYGEimgSX24vqtl6uX6JJM+g0uHJxJt4pa0J7z4DqOER0EhYmokmobO6BT4JbCpBfrCvOxqDXhxd21quOQkQnYWEimoSDTUNXyHHBN/nDjJQYLM2NxzPb6+DzcfE3UTBhYSKahION3TDrtchJjFYdhcLE9ctzUNveh81H2lRHIaIRWJiIJqGi0YkZqTHQ8kgU8pOL5qYiMdqAJ7fVqo5CRCOwMBFNkJQSFU3dXPBNfmXUaXHN0ix8cLAZ9q5+1XGIaJhOdQCiUHP8su/ufjc6+9zoHfDwUnDyq3XLsnH/J0fx3PY6fP+CQtVxiAgsTEQT1tTtAgCkWs2Kk1C4GFm8ZyTH4LEtNbDFmE6Y8l1XnK0iGlHE45Qc0QQ1OYYLU6xJcRIKR8X5CXAOeHBg+KxCIlKLhYloghod/bCa9TAbtKqjUBiakRKD+Cg9tlW1q45CRGBhIpqwpm4XR5coYDRCYFluAqrbetEyPP1LROqwMBFNgMfrQ6tzAKlWFiYKnCW5CdBqBA/kJQoCLExEE9DaMwCfBNJYmCiALEYd5qbHYlddJwY9PtVxiCIaCxPRBHDBN02V5fmJGPD4sPdYl+ooRBGNhYloAhodLug0AokWo+ooFOayE6KQGmvCtup2SMnz5YhUYWEimoCmbheSY408EoUCTgiBldMS0ehw4Uhrj+o4RBGLhYloApocLqTGcsNKmhoLs+IQa9Lhk8OtqqMQRSwWJqJxcrrc6Bnw8Ao5mjI6rQYrpyWhqrUX++q5lolIBRYmonFq7h4AwCvkaGoty0uASa/B/Z8cVR2FKCKxMBGNU5Nj6AT5FF4hR1PIpNeiOC8Rb5c1obqtV3UcoojDwkQ0To0OF2JMOliMPLuaptbKaYnQazV4cCNHmYimGgsT0TjxSBRSJcakx1VLMvHizgYel0I0xViYiMbB7fWhhUeikELrz86Hx+fDo1tqVEchiigsTETjUN3WC69PcoSJlMlNisbF89Lw9LZadLvcquMQRQwWJqJxONjYDQBIs3IPJlLnW+dMg3PAg2dK6lRHIYoYLExE43Cw0QmtEEiKMaiOQhFsboYVqwqS8MjmavQPelXHIYoILExE41DR1A1bjBE6DX90SK3/96XpaHUO4ImtNaqjEEUEvuoTjUNFo5MLvikoLMtLwNpCG+776AgcfVzLRBRoLExEY9TZO8gtBSio/OjCmeh2efAA92UiCjgWJqIxqmhyAgBHmChozE6PxdcWpuPRLdXcl4kowFiYiMbo+BVyLEwUTL5//gx4vBL3fFipOgpRWOPZDkRjVG7vRpLFiBgeiUIKnWorgSU58XimpA4pMSYkWoxYV5ytIBlReBt1hEkIESeE+JsQYqsQYpsQ4vtTEYwo2JTbHZibEQshhOooRCdYOzMZWo3A+webVUchCltjmZIzAvh3KeUKAKsAfEsIkRTYWETBxeX2orKlB3PSY1VHIfqCWJMeZ01Lwr56B+xd/arjEIWlUQuTlLJZSnlg+FMbAA+A3pH3EUKsF0KUCiFKW1tbAxCTSK1DTU54fRJz062qoxCd0tnTbTDrtXjvQJPqKERhacyLvoUQvwFQDuD3UsoTfoWRUj4opSySUhbZbDZ/ZyRSrszuADC0wzJRMDIbtDhnhg2Hm3uws7ZDdRyisDPmwiSl/AmALAA3CiGWBS4SUfApt3cj1qRDZjzPkKPgtTw/EVEGLe798IjqKERhZyyLvguFEMeHjfoAOADEBzQVUZApb3BgTrqVC74pqBl0GqycloSPDrWirMGhOg5RWBnLCNMAgD8LIT4A8CmAgwDeC2gqoiDi9vpwsMmJuRlc8E3Bb0V+ImKMOtz3MUeZiPxp1A1lpJQ1AK4LfBSi4HSkpQeDHh/XL1FIMBu0uGFFDv76yVEcaXGiIDlGdSSisMCdvolGUW4f2uF7Dq+QoxBx26o8GHUa3Pcxz5gj8hcWJqJRlDU4YNZrkZcUrToK0ZgkWoz4+rJsvLrHjmMdfarjEIUFFiaiUZTbHZidHguthgu+KXSsX50PjQAe2MhRJiJ/YGEiOgOfT+KAvRtzucM3hZg0qxlXLcnE30rr0dLtUh2HKOSxMBGdQU17L3oHvZjDBd8Ugu48Zxo8Xh8e2lSlOgpRyGNhIjqDss8WfHOEiUJPTmI0Ll2QjqdL6tDZO6g6DlFIG3VbAaJIVt7ggEGrwXRemk0h5JmSus8+zk6MRt+gFz95aT/OmXHi0VXrirOnOhpRyOIIE9EZlNkdKEyNgUHHHxUKTamxJuQnRaOkqh0+KVXHIQpZfBcgOg0pJcrt3dzhm0Le8vxEdPW7UdHoVB2FKGSxMBGdRkNXP7r63JjNDSspxM1Ki4XVrMe26nbVUYhCFgvdEKg7AAAgAElEQVQT0WmUNQwt+OaWAhTqtBqBZXkJONLSgxYntxggmggWJqLTKLc7oNUIzEpjYaLQtzQ3AVqNQElVh+ooRCGJhYnoNMrt3SiwWWDSa1VHIZo0i1GHeRlW7KrrxIDbqzoOUchhYSI6jbIGB/dforCyPD8RAx4fdh/rUh2FKORwHyaiYSP3rnG63GhxDmDA4zvhdqJQlhVvRkacGduq2lGcl6A6DlFI4QgT0SnYu4YWxqbHmRUnIfIfIQSW5yeixTmA6rZe1XGIQgoLE9Ep2B39AIA0q0lxEiL/mp9phVmvxdYqbjFANB4sTESnYO/qR2K0gQu+KezotRoszY3HwcZuNA7/YkBEo2NhIjoFe1c/0jgdR2GqOC8RUoLr84jGgYWJ6CT9g1509rmRzuk4ClPx0QYUpsbguR3HMOjxqY5DFBJYmIhOcnyaggu+KZwV5yWi1TmA9w40qY5CFBJYmIhOYncMXSHHBd8UzqanWJCVYMaTW2tVRyEKCSxMRCdp7OpHjEmHGJNedRSigNEIgeuLc1BS3YHDzU7VcYiCHgsT0Unsjn6kWzkdR+Hv6qIsGHQaPLWNo0xEo2FhIhrB7fWh1TmAtDhOx1H4S4g24Cvz0vDSrgb0DHhUxyEKaixMRCM0d7vgk+AIE0WM61fkoGfAg1d2N6iOQhTUWJiIRuCRKBRpFmXFYU56LJ7aVgsppeo4REGLhYloBLujHya9BvFRXPBNkUEIgRuW56CiyYmdtZ2q4xAFLRYmohEau/qRZjVDCKE6CtGUuXRhOmJMOjzJxd9Ep6VTHYAoWPikRFO3C8tyE1RHIZoSI49GmZdhxRt7GzEn3QqL8fO3hnXF2SqiEQUdjjARDWt1DsDtlTxDjiJScV4ivFKitKZDdRSioMTCRDTssyNReIUcRSBbjBH5tmjsqOmAj4u/ib6AhYlomL3LBZ1GwBZjVB2FSInivER09rlRyZ2/ib6AhYlomN3Rj5RYE7QaLvimyDQrLQYWow4l1ZyWIzoZCxMRACklGrtcSOcO3xTBdBoNinLicajJia6+QdVxiIIKCxMRgIaufvS7vUjj+iWKcEvzhq4S3cHF30QnYGEiAlBu7wbAHb6J4qMMmJESg9KaTnh9XPxNdBwLExGGCpMAkBrLKTmi4rwEOAc8ONjYrToKUdBgYSICcMDugC3GCIOOPxJEM1JjEGfWo6S6XXUUoqDBdwciDI0wcTqOaIhGCCzNS8DR1l5UtfaojkMUFFiYKOK19wyg0eFCmpXTcUTHFeXEQyOAZ7fXjX5nogjAwkQRjwu+ib4oxqTH7HQr/r6zHi63V3UcIuVYmCjiHS9MHGEiOlFxXgK6+tx4c1+j6ihEyrEwUcQrtzuQEWdGlEE3+p2JIkh+UjTyk6LxVEmt6ihEyrEwUcQrt3djTnqs6hhEQUcIgRtW5GB3XRf21ztUxyFSioWJIlq3y43qtl7My7CqjkIUlK5ckokogxYbttaojkKkFAsTRbQDw+uX5mayMBGdSqxJj8sXZeDVvXZ09vJ8OYpcLEwU0coahqYZOMJEdHo3rsjFoMeH50uPqY5CpAwLE0W0/Q0OpFlNSLIYVUchClqFqTEozkvAU9tqeb4cRSwWJopo+xscmMvRJaJR3bQyF/Wd/fiookV1FCIlWJgoYvUMeFDd1ou56SxMRKM5f3YKUmNN2LCNWwxQZGJhoohV3uCAlMC8TG4pQDQavVaDdcXZ2Hi4lefLUURiYaKIVXb8CjlOyRGNyXXLsqDXCjzJUSaKQCxMFLHKGhxIiTUiOYZHohCNRXKMCRfPTcMLO+vRO+BRHYdoSrEwUcTa3+DgdgJE43TTyhw4XR68sqdBdRSiKcXCRBGpd8CDo609nI4jGqfF2fGYkx6LRzdXw8ctBiiC8LRRikgHGrshJXiFHNEonimp+8JtczOseH7HMfzslbLPfulYV5w91dGIphRHmCgiHT9IdB6PRCEat3kZViRGG/Dx4RZIyVEmigwsTBSRyuwO2GKMSInlgm+i8dIIgXNm2GDvcqGyhVsMUGRgYaKIVMYF30STsjA7DlazHh8f4s7fFBlYmCji9A16cKSFC76JJkOn0eDs6Umoae9DdVuv6jhEAcdF3xQRRi5crW3vhU8CHT2Dp1zQSkRjU5STgI8qWvDxoRb89JJZquMQBRRHmCjiNHT1AwAy4s2KkxCFNoNOg1UFSahs6fnsQgqicMXCRBHH3tWPaKMOsSYOsBJNVnF+Ikx6Df7y0RHVUYgCioWJIo69y4WMOBOEEKqjEIU8k16LFfmJeKe8CZXNTtVxiAKGhYkiitvrQ4vThYw4TscR+cvKaUkw67W47+OjqqMQBcyohUkIES2E+IsQ4hMhxA4hxH9NRTCiQGh0uOCTYGEi8qNoow43rMjBq3sacKiJo0wUnsYywmQF8KyU8hwAxQCuFEKkBjYWUWAcX/CdzsJE5Ff/tGYaLEYdfvtOheooRAExamGSUtqllJuHP40GMAiga+R9hBDrhRClQojS1tbWAMQk8g97Zz+iDFpYzXrVUYjCSlyUAd9eW4APK1rw6dE21XGI/G7Ma5iEEFoAGwD8SErpGvk1KeWDUsoiKWWRzWbzd0Yiv2no6kdGnJkLvokC4KaVuciIM+M3b1fA5+MZcxRexlSYhBB6AE8BeF5K+U5gIxEFRv+gF83dLuQkRqmOQhSWTHotfnDBDOyrd+D1fXbVcYj8aiyLvg0AngPwmpTyucBHIgqMmvZeSAB5SRbVUYjC1mULMzA7LRb/++4hDHi8quMQ+c1Ydu67HcAaAIlCiG8O3/YDKeXOgKUiCoCq1h7oNAKZ3OGbyO9GHjO0PD8Rj26pxl3P78WqgqTPbl9XnK0iGpFfjFqYpJT3AbhvCrIQBVR1ey+yEqKg13L7MaJAKki2YHqyBR9VtGBJdjzMBq3qSESTxncOigj9g140drmQlxStOgpRRLhobipcbi8+OdyiOgqRX7AwUUSoHV6/lM/CRDQl0qxmLMqOw6dH29HWM6A6DtGksTBRRKhq64VWI5CVwCvkiKbKBXNSodUIvLbXDim5zQCFNhYmigjVbb3Iiuf6JaKpFGvS44I5qTjS0oN9DQ7VcYgmhe8eFPacLjfsXf1cv0SkQHFeAjLjzXhzXyMc/W7VcYgmjIWJwl5pTefw/kssTERTTSMEvrYwA70DHvzu3UOq4xBNGAsThb1t1e3QCoFsrl8iUiIjzowV0xLxVEkt9hzrGv0biIIQCxOFvW1VHciMN8Og4z93IlXOm5WC5Bgjfvryfni8PtVxiMaN7yAU1noGPChrcCDPxuk4IpVMei1+8dU5KLd344mttarjEI0bCxOFtdKaDnh9kuuXiILAxXNTsabQht+/dwgNXf2q4xCNCwsThbWS6g7oNAI5CSxMRKoJIfCfX5sLCeAnL+7j3kwUUliYKKyVVLVjfqaV65eIgkRWQhT+9cuzsKmyDc9uP6Y6DtGY8V2EwlbfoAf76h0ozk9UHYWIRvjGsmycVZCIX795AMc6+lTHIRoTneoARIGys7YTHp/E8vxENHRyvQSRas+U1H328cppSdhR04mbH9uOW8/KgxDis6+tK85WEY/ojDjCRGFrW1U7tBqBJTnxqqMQ0Uniowy4eG4qjrb2YntNh+o4RKNiYaKwVVLVgXkZVliMHEglCkbLchNQYLPg7f1N6OgdVB2H6IxYmCgsdfUNYs+xLqyYxvVLRMFKCIErFmdACOClXfXw8ao5CmIsTBSW3i5rgscnccm8NNVRiOgM4qIM+PLcNFS19aKkmlNzFLxYmCgsvbqnAfm2aMxJj1UdhYhGUZQbj+nJFrxT1sipOQpaLEwUdpocLpRUd+DSBeknXHlDRMFJCIHLF2VAIwRe3FUPn49TcxR8WJgo7Lyxzw4pgUsXpKuOQkRjFBdlwCXz0lDd1osnt/GsOQo+LEwUdl7dY8f8TCvybRbVUYhoHJbkxGNGigW/ebsCte29quMQnYCFicJKVWsP9jc4OLpEFIKGpuYyodMK/OiFfZyao6DCwkRh5bW9dggBfGU+CxNRKLKa9bj7K7OxvboDT2ytUR2H6DMsTBQ2pJR4bY8dy/MSkWo1qY5DRBN09ZJMrC204bfvVKCmjVNzFBxYmChslNu7UdXWi0sXcnSJKJQJIfDfV8yHXqvBj1/k1BwFBxYmChuv7mmAXitw8dxU1VGIaJJSrSbcfcnQ1NxTJbxqjtTjIVsUFnw+idf3NuKcGTbERRlUxyGiSXimpA7A0DT79GQLfvXGQTj7PYiP/vxne11xtqp4FKE4wkRhYXtNB5q6Xbh0YYbqKETkJ0IIXLYoAxDAy7sbIHnWHCnEESYKec+U1OHl3Q0waDXo6Bn87LdTIgp98VEGXDQnFa/ttaO0thNLcxNUR6IIxREmCnkenw9lDQ7MSouBQcd/0kThZlleAvKSovHW/kY4+t2q41CE4rsLhbx9xxzod3uxODtedRQiCgCNELhiUQZ8UuIVTs2RIixMFNKklNh8pA0psUYUJPMoFKJwlWgx4oLZqTjU7MSeY12q41AEYmGikLblSDuaul1YVZAEIYTqOEQUQCumJSI7IQpv7GtES7dLdRyKMCxMFNIe2lQFi1GHBZlxqqMQUYBphMCVizPh9vrw01fKODVHU4qFiULW4WYnPjnciuX5idBp+U+ZKBLYYow4f3YK3j/QjNf22lXHoQjCdxkKWY9sqoZJr8HyPF5mTBRJzipIwsKsOPzitXK0OgdUx6EIwcJEIanVOYCXdzfgqiWZiDJyOzGiSKIRAr+7ej76Br24m1NzNEVYmCgkPbm1Bm6fD7eelac6ChEpUJAcg7vOm4F3ypvw5v5G1XEoArAwUcjpH/TiyW21+NLMFOTbuJUAUaS64+w8LMi04uevlqO9h1NzFFgsTBRyXtpdj84+N+44m6NLRJFMp9Xgf65agB6XBz9/tVx1HApzLEwUUnw+iUc2VWN+phXLuNibKOIVpsbgu+dNx5v7G/E2p+YogFiYKKS8d6AZVW29uP3sfG5USUQAgPWr8zE3IxZ3v1qGjt5B1XEoTPHyIgoZUkrc80El8pKi8eW5qarjEJFCz5TUnfD52sJk3PfRUdz82HZctzQbALCuOFtFNApTHGGikPHegWYcaOzGP68t4EaVRHSCNKsZa2fasK/egXK7Q3UcCkMcYaKgNfI3SCkl/vLRESRGG9A36P3Cb5dEROfMSEa5vRuv7rEjLzFadRwKM/w1nUJCRZMTdocLawuTodVw7RIRfZFWI3DVkkz0DXrwBheAk5+xMFHQk1Lig4pmJEQbsCCLh+wS0emlWc1YW5iMPce68F55k+o4FEZYmCjoHWpywt7lwtpCG0eXiGhU5xTakGY14aevlKGrj1fNkX+wMFFQGxpdakF8lB4Ls+JVxyGiEKDTaHDl4kx09g7i31/jhpbkHyxMFNQONTvR0NXPtUtENC7pcWb887kFeGWPHe9yao78gIWJgpaUEh8Ojy4tyuboEhGNz7fXFmB2Wix++vJ+bmhJk8bCREGrosmJ+s5+rOHoEhFNgF6rwe+uXgBHvxu/4NQcTRILEwUll9uLN/bZYYsxYjFHl4hogmanx+I7507H63vteKeMWw3QxLEwUVC676Mj6Oxz42sL0jm6REST8q010zA3IxY/fbkM7T0DquNQiGJhoqBT09aL+z+pwoJMK/JtFtVxiCjEHZ+a63a5cferZZBSqo5EIYhHo1BQkVLiF6+Vw6jT4OJ5aarjEFEIO/kIpXMLk/HW/ib84G97UZSb8NntPKSXxoIjTBRU3i1vwieHW3HX+TMQa9KrjkNEYeTsGTYU2Cx4fZ8dzd0u1XEoxLAwUdDoG/TgP14/gFlpsbhxRY7qOEQUZjRC4OqiTBh0Wjy7vQ5ur091JAohLEwUNO754AjsDhd+ddkc6LT8p0lE/hdj0uOaJZlocQ7gjX28ao7Gju9KFBQqm514eFMVrl6SiSU5CaN/AxHRBE1PicHq6TbsqOnAvvou1XEoRLAwkXKOPje++eROxJh0+MnFM1XHIaIIcP7sFGTFm/Hy7gbUtfepjkMhgIWJlHJ7ffjW0ztxrLMP91+/BIkWo+pIRBQBtBqB65ZmQwjgO8/ugsvtVR2JghwLEykjpcTdr5Th06Pt+M0V81Gcn6g6EhFFkPhoA65anIW99Q786IV93J+JzoiFiZR5eFM1nttxDN9eOw1XLslUHYeIItDs9Fj8y0Uz8fpeO/7wj0rVcSiIjbpxpRCiEMBjAOqklNcFPhJFgp+9XIanS2oxNz0WaVbzFzaYIyKaKneek4/qth7c80El8pOicdmiDNWRKAiNZYSpGMA9gQ5CkaPc7sDzpXXIiDfjqiVZ0AieFUdE6ggh8KvL5mFFfiJ+/MI+7KjpUB2JgtCohUlKuQFA0xRkoQjQ3jOA9Rt2Isqgw/XLc2DQcVaYiNQz6DT46/WLkRlvxvoNpaht71UdiYKMX96thBDrhRClQojS1tZWfzwkhSGP14d/fmY3WnsG8I3ibB59QkRBJS7KgEdvXgoJ4JbHd6Crb1B1JAoiYixXBQgh1gC4cyxrmIqKimRpaakfolG4+c83DuCRzdX43dULMOjhkQREFJyq23rx6JZqZMWbcctZedBrNTygN4wJIXZKKYtGux/nQ2hKvLK7AY9srsbNK3NxFa+II6IglpcUjauXZKKmvQ9/Lz0GH7cbIIzhKjmi8TjV1W72rn7c/8lR5CZGY5rNwiviiCjozc+MQ3e/G2+VNeHt/Y24fjkPBI90YxphklJ+zC0FaCJ6Bzx4qqQW0UYdvr4sC1oNr4gjotCwaroNZ01LxJaj7Xh4U5XqOKQYp+QooF7cVY8elwffKM5GDBd5E1GIuXheGuamx+JXbx7E63vtquOQQixMFDCHmrpR0eTEebNSkBkfpToOEdG4aYTA1UVZWJobjx/8bS+2Hm1XHYkUYWGigPD4fHhzfyOSLAasLOAZcUQUuvRaDR66sQg5iVFYv6EU5XaH6kikAAsTBcTWo+1o6xnEJfPSoNPwnxkRhba4KAM23LYMMSYdbnp0B+ra+1RHoinGdzLyO6fLjQ8rWlCYEoPC1FjVcYiI/CLNasaG25bB4/PhhkdL0OocUB2JphALE/nde+XN8HglLpmfpjoKEZFfFSTH4NGbl6KlewA3P7YdTpdbdSSaItyHifzqWEcfdtZ14uzpSUiyGFXHISLyi5P3j7umKAtPbqvB1/6yBTevyIVOOzT+wB3BwxdHmMhvfD6JN/bZEWPUYW1hsuo4REQBU5gagysXZ6KqtRdPl9TB7eVxT+GOhYn85uXdDTjW2Y8L56TCpNeqjkNEFFCLsuNx+cIMHG524slttTwjM8yxMJFfOF1u/OadCmTGm7EwO051HCKiKbE0LwFXLM7E0ZYePLG1Br0DHtWRKEBYmMgv7vmgEm09A7h0QTo0gsefEFHkWJITj6uLMlHT1suF4GGMhYkmrbLZice21OC6pVnc0ZuIItLCrHhctywbu+q6cMMj2+HoZ2kKNyxMNClSSvzitXJEG3X40YUzVcchIlJmXoYV931jMcrtDnz9wW3cpynMsDDRpLy1vwmfHm3HDy8sREK0QXUcIiKlLpyTioduLEJVWw+ueWAr6ju5I3i4YGGiCesd8OBXbx7A7LRYrFvGvUeIiABgTWEynrqtGG09A7j6/q040tKjOhL5ATeupAn7y0dH0Ohw4d51i6DVcKE3EdHIDS5vXpmLx7bU4NJ7N+PmlbmfrfHk5pahiSNMNCFVrT14aFMVrlyciSU5CarjEBEFnTSrGd9cnQ+jToOHN1ejqpUjTaGMhYnG7fhCb5NOi3+5uFB1HCKioJVoMWL96mmIM+vx+Kc1OGDvVh2JJoiFicbtvo+PYlNlG350USGSY0yq4xARBTWrWY/1Z+cj1WrCM9tr8cLOetWRaAK4honG7JmSOlQ2O/H4pzWYn2mFVogvHEhJRERfFGXU4bZVeXhqWy1++Pe9cPS7cduqPNWxaBw4wkRj1tE7iOd2HENKrAlXLMqE4I7eRERjZtRpcdOKXFw0JxX/+cYB/N97hyClVB2LxoiFicakf9CLp0tqISHxjeJsGHT8p0NENF46rQb3rluEa4uy8OcPj+Bnr5TB62NpCgWckqNRSSnxry/tQ5PDhRtX5CLRYlQdiYgoZOm0GvzmynmIjzbg/k+OosU5gHuuWwSzQas6Gp0BhwloVI9tqcEre+z40qwUFKbGqI5DRBTyhBD4ycUz8ctL5+AfB5ux7uFt6OgdVB2LzkD4e/60qKhIlpaW+vUxSZ0PK5pxx4adWFuYjDWFNmi4bomIyK/K7Q48v+MYrGY9bl75+Sg+N7icGkKInVLKotHuxxEmOq2dtR34p6d3YVZaDP5w7QKWJSKiAJiTbsVtq/LQN+jF/RureP5ckGJholM63OzErY+XIjXWhMdvWYYYk151JCKisJWTGI07z5kGg1bgoU1VOGB3qI5EJ+Gib/rCXkpdfYO4/5OjkBK4akkW3itvVpSMiChy2GKMuPOcaXhqWy2eLqlDTmI0bj87j1u4BAmOMNEJegc8eGxLDQa9Ptx8Vi4Sog2qIxERRYwYkx63n52PORlW/Pqtg/i3l8vg9vpUxyJwhIlGGPT48MTWGnT2DeKWs/KQZjWrjkREFHH0Wg2uW5qFxhlJ+MtHR3Gsow9/+cZiWM1cGqESR5gIAOD1STyzvRYNnf24bmkW8pKiVUciIopYGiHwowtn4n+vmo+S6nZc+ddPUd3WqzpWRGNhIvikxIu76nG4uQeXLcrA7HSr6khERATg6qIsbLi1GO09A/javZvx8aEW1ZEiFqfkCO+WNWHPsS6cPzsFS3MTVMchIiKceEHO7avy8eS2Wtzy2A5cOCcVZ09PghCCezVNIY4wRbgHNx7FpiNtWJ6fiDUzbKrjEBHRKcRHG3DnOdMwJ8OKd8qb8HzpMQx6uBh8KnGEKYK9tKse//VWBeZlWPGV+Wm8dJWIKIgZdBp8fWkWPrGa8P6BZrQ5B7Cm0IZcrjmdEhxhilAfHGzGj1/Yh5XTEnH1kkzu4k1EFAKEEFhTmIwbVuSgs8+NS+7ZhFd2N6iOFRFYmCLQpspWfOupXZidHosHblgCnZb/DIiIQsnM1Fh859wCzEqLxfee34Mf/G0vegc8qmOFNb5TRphtVe24Y0MppiVbsOFWHnlCRBSq4qIMeG79cvy/cwvw0u56fPXPm1HWwCNVAoWFKYLsrO3EbY/vQGZ8FJ66bRnioriLNxFRKNNpNfj+BYV4+vZi9A56cMV9n+K+j4/Aw93B/U5IKf36gEVFRbK0tNSvj0kTd/yy1IaufjyyuQrRBh3uWJ2PWI4sERGFld4BD17Z04Byezey4s24ckkmkmNM3HpgFEKInVLKotHux6vkIkCjox+Pbq6GSa/FbavyWJaIiMJQtFGHdcuysa/egdf22nHvh0dw/uwUXLs0C1qNfy7sOfmw9tMJx5LGKbkw19DZj4c3VUOvFbh9VT6n4YiIwpgQAguy4vDd86ajINmCt8uacO0DW3msih+wMIWxnbWdeHhzFUx6DdavnoaEaJYlIqJIEGvS44blObhqSSYONTtx8Z824rEt1fD5/LsMJ5KwMIWpbVXtuOGREliMOtxxdj7LEhFRhBFCYHF2PN6/6xysyE/EL18/gOse2oa69j7V0UISC1MY2ni4FTc/th0ZcWbcsZrTcEREkSzVasKjNy/F/1w1Hwft3bjoTxuxYWsNR5vGiYUpzLxT1oTbnyhFXpIFz61fzgXeREQEIQSuKcrCu3etxpKcePz81XJc9+A2HGlxqo4WMniVXJiQUuLPHx7B798/jIVZcXj8lqUcWSIioi9c2XbRnFTYLEa8XdaEC/+wCatn2LCm0IabVuaqCRgiWJjCQN+gBz/8+168tb8JVyzKwH9dMQ8mvVZ1LCIiCkJCCBTlJmBmWize2t+Ijw61YF99F6YnW7CyIEl1vKDFKbkQd6yjD1fc9yneKWvCT788C/93zQKWJSIiGpXFqMM1RVm45axcSADrHi7B7U+UYuvRdvh7U+twwBGmEPYfrx/Aczvq4JMSN67IRbRRh2e3H1Mdi4iIQsj05Bh890vT0dk3iCc+rcE/DjZjVlosbjkrF5cuSD/jL+E+KeF0edDZOwiTXotUq2kKk08tHo0Sgpq7Xfj1mwfx2l47bBYjblieg6QYo+pYREQUwtYVZ8Pl9uKV3Q14bEsNDjU7kRhtwLK8BIjhjcLrOvoBAANuLzp6B9HV74Z3+Go7AeDL89JwVkFSSO30zaNRwpDb68MTn9bgj/+oxKDXh3NnJuOcGTbotZxZJSKiyRm5OPzGFTk42tqLbVXt2FnbCQAYObxi0GqQFmfGnPRYxEUZEB9lQGltB97c34jOvkG/HscSLFiYQoCUEpuPtOFXbxzEoWYn1hTa8O9fnYNPj7arjkZERGFICIGCZAsKki1j/p7pKRa8vb8RW46245+e3ok/XrsIZkP4rKllYQpiTpcbL+9uwJNba1HZ0oOMODMevGEJzp+dAiEECxMREQUNjRC4ZH464qMNeHN/I77+0DY8fFMRkizhsWSEa5iCjJQSv3//MLZXd2D3sS4MenzIiDNjeX4i5mdaOf1GRERBLyHagO8+txupVhNe+/YqWKOCdxNlrmEKIR6vD6W1nXj/QDPeP9CMuo4+6DQC8zOtWJ6fiMz4KNURiYiIxuyiual46vZiXPfgNvzXWwfx26vmq440aSxMijR3u7DlSBs2V7bhw0Mt6Opzw6DV4KyCRCzOjsec9FhEG/m/h4iIQtPS3ATcfnYeHvikCl9bmB7ym2LyHXmKOPrd2F7dgUe3VONoSw9anAMAALNei8LUGMyaG4sZyRYYuekkERGFibvOm4F3yprwry/vxzvfXbM5E4MAAAqkSURBVB3Si8BZmAKk2+XGjuoObKtqx9aqdpTbuyEloNcK5CZGY3F2PAqSLUi1mqAR4XXpJREREQCY9Fr89xXzsO6hEvzxg8P41//f3p0HV1WecRz/PgkJJIHEhE0QQiQsshVFsEqxoqMtxb0ztVSm1TLjQqWtY+tClxlHx6V1rbW2OkyHKiIqZaaIrUKpyI4wqLjgwiKgLBICCYWEhOTpH+dNe5sWbgIk95j7+8y8wzlPzj33veeBk4dz3nvebwxKdZeOmQqmE2Tmqq2UH6jh/R2VrN9RySdlB3AgM8MoLsrl/IHd6Nslj+KiXNpp4LaIiKSJ0aVdmDCqN9OWbObSL/Vk6CkFqe7SMVHBdJw+3Lmfeeu288KabeyqjG6zdc9vz3kDulLarSPFRbn6ZpuIiKS1qeMHsfCDz7lt9jr+MuUrX8jfiyqYjsGuymrmvrWdOW9+xvodlWQYFBflMX5YEYN75FOUl53qLoqIiMRGQU4Wd18+hBtnrGXaks1MHlua6i41mwqmJnB3NpcdYNnGPcx/byfLNpRR7zC8VwF3XjqYS4b3ZP57u1LdTRERkdgaN7QH44aczKN//4hRJYWMLClKdZeaJa0LpsR5cxLVu7PvYC1byw+w4fMD7KyoYntFNQDFRblMOb8fl59xCqVdm/7IeBERkXR31xVDmPDkfiZOW8XjV4/gosHdU92lJkvrggngcH092/dVs31fFTsrqtlZWc2uymoOHa4Hoq/9l3bNY9SpRfTr2pGivGzMjFWbylm1qTzFvRcREfni6NapA7Mnj+b701dzwzNruPfKYUw4qzjV3WqStCuYqmrqeHPrXlZtLuelddvZVn6Q2rpoepicrEy653fgjOJCeuR3oGdhDj30tX8REZETpigvm+eu+zKTZ6zljjnvsHv/IaZc0A+L+e/aJhVMZjYFmAgY8Ii7P9+ivTqBqmvrWLtlLys27WHFxj28/ek+auscM+iR34GRJUWc2jmPXoU5FORkxT5hIiIiX3S52e2Yds1Ibp+9jocWfMTufx7iJ18bSEFOfOecS1owmVkpMAk4G2gPvGFm8919b0t37mjcnUOH6zl0uJ6aw/VU1dSxvaKKbeUH2ba3ik/LD/LJngO8+1klNXX1ZBgM63USk8acytl9O3Nmn0Lmvb0jlR9BREQkbWVlZvDgt4bTtVN7nly8iWdWbqF/t46MKC5kRJ9CRhQX0rdLHhkZ8biQ0ZQrTBcAc929Bqgxs8XAaODlFu3ZESx4fxc3PbuWmrr6I27TcPWoV2Eu14zuwzmlnRlVUkSnDvGtXEVERNJNRoYxdfwgLhzcnZUb97B2617+9u5OZq3eBsDNF/bn5gsHpLiXEXP3o29gNhXY7+6Ph/V7gI/dfXrCNtcD14fVgcCHTXz/LkBZM/ssrUf5iS/lJt6Un3hTfuIrFbnp4+5dk23UlCtMe4HOCesFIfZv7v4U8FSzugeY2Rp3H9nc10nrUH7iS7mJN+Un3pSf+IpzbprybPKlwHgzyzSzHGAs8EaL9kpEREQkRpJeYXL3d81sHrAccOBhd9doaREREUkbTXqsgLvfB9zXAu/f7Nt40qqUn/hSbuJN+Yk35Se+YpubpIO+RURERNJdU8YwiYiIiKQ1FUwiIiIiSaSsYDKzKWa2wsxWmtm3U9WPtsbMBprZcjOblRC7J8RWmNnYEMsys6fMbImZLTazoSGeb2Yvhvh8M+sV4j3N7JUQn2NmBSE+yMxeD/E/mll2iI8J77nMzH5laT7njJnlmdnvwrFabWb3hrhyEwNmdpKZvZBwTrolxJWfmLDIAjObHtaVmxgwswwz22Nmi0JbGOJtLz/u3uoNKAXWAtlAJ2A9UJiKvrS1BnwPmADMCusXAC+H5Z7AB0SD/ScBT4T46cDysHwXcFtYvhx4Liw/DVwVln8M3BeWXwfOCsuPADcQFeIfAL1DfA7w9VQfmxTnpScwJixnED3c9WrlJh4N6A4MDsvtgI+Bq5Sf+DTgpnCcpuu8Fp8GFAJ/bhRrk/lJ1QG+DrgzYf1J4OJUJ76tNKJnZTUUTPcA1yb87FVgCPAsMDYh/iGQBywDSkIsA9gSlrcA7cJyD2A1UcG7OWEf5wAvAv2BRQnx7wAPpPq4xKUR/SfhHeAh5SZ+LRzD9cpPfBpQAvwV6EtUMOm8FpMWcrIVWAL8A/hmW81Pqm7JNX70eRmQ9LHkckyOdKyTxt29Hsg0swwgy90PN9q2M7CnGftOe2aWSfS/pluBjig3sWJm9wPvAQ+j/MRCuK3yGPBDoGESUZ3X4uMTdy9293OJ7nDcTTTfbJvLT6oKpr1EU6w0+J/pVuSEOdKxbmq8PvwFrk24H5y4bX4z9p3WzCwLmAE87+6voNzEjrvfAfQmOvH3R/mJgxuBV919Y0JM/3ZiIhzHhuVPgVeAU2iD+UlVwaTpVlrPUuAyADPrwn8mR06MDwRq3b2iUfwi4K2wn9XAuLB8JbDE3auBfWY2ODEObAT6mFlDdX9FiKetMChxFjDX3RsG5Cs3MWHRlyUajslBoAL4DcpPHIwCvmrRF1n+AJxHlCPlJgbMrJ+Z5YXlfKLxS4/TFvOTwvueU4FVwEpgUqrvw7alxn+PYcogupy9PBzr8SGeQ3Q/eQnR/eNRId4FmAcsBhYC/UK8L/BaiL8EdA3xM8O+FwMzgdwQH0dUBC8FfgtkpPq4pDgnPyC6jLwooZ2p3MSjEY2RmRWO6wrgASBT+YlXC+e26TqvxacRjSFaHNoyojFMbTI/etK3iIiISBJ6cKWIiIhIEiqYRERERJJQwSQiIiKShAomERERkSRUMImIiIgkoYJJREREJAkVTCKSUma2oRnb/jxhRvMFZjbAzE42s0Ut2EUREdqlugMi0vaZ2bVEU1wk+hPwTMI2DxI9mDBRCXCFuy81swKiKUtOc3c3s2vCPn/d6L1eI5rgONEgd887zo8hImlMBZOItDh3n25mw4HZRE88/yXwNnAzUBe2+Wnj14XpMCrCzyvC+gwzO0g0CefU//Ne5/+f/bx/4j6NiKQj3ZITkdbSDmgfWiZQClzC0c9DvYHPAMzsbqJJPQ8B2USF1C+AkUd7UzNrD9QcZ99FJM1pahQRaXFmNpHoatImoIpo/qnlRJN0Pg+UJWw+lGjyzd5AbfjZUuBnRMXVucBE4CGi+aKyiQqiW4AnknTlMXefeUI+lIikFRVMItLiwgziDWOI6omuEpW5e52Z/d7dJydsu8Hd+5nZ/cAad5+d8LNOwMVAMbA2hLOIJuV8OmwzF7jS3esSXjcb+K67V7XcpxSRtkxjmESkxbn7bmC3mV0G3A4YYGZWCdxKtDITuD/JrjoBp4XlMeHPXGA08HRYHwAsM7PE1w0jug0oInJMVDCJSKsIV4ceBc5y97IQO4Pom3LDiW6tZQDXhZdMB/Y12s1JRFeYDiTEMoH9jbYb4+6HE977rRPzKUQkXalgEpHWUgM4MNTMVhLdSjud6FtzDZ4FqhKvDpnZQne/PazmEg0W/6jRvgsbrS9tdIWp/3H3XkTSmsYwiUirMbMhwI+ICphaonFID4dbdiIisaWCSURERCQJPYdJREREJAkVTCIiIiJJqGASERERSUIFk4iIiEgSKphEREREkvgXNM/4wKLehRUAAAAASUVORK5CYII=
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="정렬(Order)">정렬(Order)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="연봉-King!">연봉 King!</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="o">.</span><span class="n">sort_values</span><span class="p">(</span><span class="n">by</span><span class="o">=</span><span class="s1">'가입자수'</span><span class="p">,</span> <span class="n">ascending</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>사업장명</th>
<th>가입자수</th>
<th>신규</th>
<th>상실</th>
<th>고지금액</th>
<th>인당고지금액</th>
<th>평균월급</th>
<th>평균연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>3621</th>
<td>삼성전자(주)</td>
<td>103237.00</td>
<td>427.00</td>
<td>496.00</td>
<td>44035185740.00</td>
<td>426544.61</td>
<td>4739384.54</td>
<td>56872614.46</td>
</tr>
<tr>
<th>2647</th>
<td>현대자동차(주)</td>
<td>67738.00</td>
<td>133.00</td>
<td>352.00</td>
<td>28575086920.00</td>
<td>421847.22</td>
<td>4687191.32</td>
<td>56246295.87</td>
</tr>
<tr>
<th>11133</th>
<td>엘지전자(주)</td>
<td>40100.00</td>
<td>116.00</td>
<td>202.00</td>
<td>16446605260.00</td>
<td>410139.78</td>
<td>4557108.69</td>
<td>54685304.27</td>
</tr>
<tr>
<th>117297</th>
<td>에스케이하이닉스 주식회사</td>
<td>27859.00</td>
<td>157.00</td>
<td>162.00</td>
<td>11583565820.00</td>
<td>415792.59</td>
<td>4619917.69</td>
<td>55439012.26</td>
</tr>
<tr>
<th>154297</th>
<td>(주)이마트</td>
<td>27390.00</td>
<td>300.00</td>
<td>308.00</td>
<td>6383200960.00</td>
<td>233048.59</td>
<td>2589428.81</td>
<td>31073145.72</td>
</tr>
<tr>
<th>130001</th>
<td>엘지디스플레이(주)</td>
<td>26785.00</td>
<td>59.00</td>
<td>115.00</td>
<td>11317077400.00</td>
<td>422515.49</td>
<td>4694616.56</td>
<td>56335398.67</td>
</tr>
<tr>
<th>167214</th>
<td>삼성디스플레이(주)</td>
<td>23301.00</td>
<td>78.00</td>
<td>125.00</td>
<td>9980636760.00</td>
<td>428335.13</td>
<td>4759279.17</td>
<td>57111350.07</td>
</tr>
<tr>
<th>382474</th>
<td>주식회사 케이티</td>
<td>22659.00</td>
<td>32.00</td>
<td>87.00</td>
<td>9682304700.00</td>
<td>427305.03</td>
<td>4747833.68</td>
<td>56974004.15</td>
</tr>
<tr>
<th>2783</th>
<td>한국전력공사</td>
<td>22536.00</td>
<td>95.00</td>
<td>67.00</td>
<td>8903739980.00</td>
<td>395089.63</td>
<td>4389884.82</td>
<td>52678617.80</td>
</tr>
<tr>
<th>4893</th>
<td>홈플러스(주)</td>
<td>21626.00</td>
<td>139.00</td>
<td>262.00</td>
<td>4644195820.00</td>
<td>214750.57</td>
<td>2386117.44</td>
<td>28633409.29</td>
</tr>
<tr>
<th>8520</th>
<td>(주)엘지화학</td>
<td>20506.00</td>
<td>16.00</td>
<td>44.00</td>
<td>8500776520.00</td>
<td>414550.69</td>
<td>4606118.82</td>
<td>55273425.79</td>
</tr>
<tr>
<th>2710</th>
<td>대한항공(주)</td>
<td>18176.00</td>
<td>613.00</td>
<td>119.00</td>
<td>7413092120.00</td>
<td>407850.58</td>
<td>4531673.10</td>
<td>54380077.17</td>
</tr>
<tr>
<th>423104</th>
<td>(주)포스코</td>
<td>17351.00</td>
<td>14.00</td>
<td>61.00</td>
<td>7358611060.00</td>
<td>424102.99</td>
<td>4712255.50</td>
<td>56547065.95</td>
</tr>
<tr>
<th>382884</th>
<td>한국철도공사</td>
<td>17205.00</td>
<td>48.00</td>
<td>57.00</td>
<td>5875923540.00</td>
<td>341524.18</td>
<td>3794713.13</td>
<td>45536557.51</td>
</tr>
<tr>
<th>382436</th>
<td>국민은행(주)</td>
<td>16849.00</td>
<td>39.00</td>
<td>71.00</td>
<td>6915773240.00</td>
<td>410456.01</td>
<td>4560622.29</td>
<td>54727467.43</td>
</tr>
<tr>
<th>166114</th>
<td>농협은행주식회사</td>
<td>16748.00</td>
<td>140.00</td>
<td>173.00</td>
<td>6453310020.00</td>
<td>385318.25</td>
<td>4281313.87</td>
<td>51375766.42</td>
</tr>
<tr>
<th>471924</th>
<td>서울교통공사</td>
<td>16450.00</td>
<td>68.00</td>
<td>82.00</td>
<td>6539954360.00</td>
<td>397565.61</td>
<td>4417395.72</td>
<td>53008748.61</td>
</tr>
<tr>
<th>3943</th>
<td>스타벅스커피코리아(주)</td>
<td>15789.00</td>
<td>212.00</td>
<td>304.00</td>
<td>2502689740.00</td>
<td>158508.44</td>
<td>1761204.88</td>
<td>21134458.50</td>
</tr>
<tr>
<th>3104</th>
<td>국민건강보험공단</td>
<td>15241.00</td>
<td>79.00</td>
<td>131.00</td>
<td>5460419500.00</td>
<td>358271.73</td>
<td>3980797.05</td>
<td>47769564.55</td>
</tr>
<tr>
<th>2639</th>
<td>(주)우리은행</td>
<td>14241.00</td>
<td>43.00</td>
<td>60.00</td>
<td>5763278900.00</td>
<td>404696.22</td>
<td>4496624.69</td>
<td>53959496.29</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="신규-채용-King!">신규 채용 King!</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="o">.</span><span class="n">sort_values</span><span class="p">(</span><span class="n">by</span><span class="o">=</span><span class="s1">'신규'</span><span class="p">,</span> <span class="n">ascending</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>사업장명</th>
<th>가입자수</th>
<th>신규</th>
<th>상실</th>
<th>고지금액</th>
<th>인당고지금액</th>
<th>평균월급</th>
<th>평균연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>313193</th>
<td>쿠팡풀필먼트서비스 유한회사</td>
<td>12164.00</td>
<td>4063.00</td>
<td>4602.00</td>
<td>602010580.00</td>
<td>49491.17</td>
<td>549901.88</td>
<td>6598822.54</td>
</tr>
<tr>
<th>257899</th>
<td>쿠팡풀필먼트서비스 유한회사</td>
<td>13791.00</td>
<td>2375.00</td>
<td>1079.00</td>
<td>2561355180.00</td>
<td>185726.57</td>
<td>2063628.60</td>
<td>24763543.18</td>
</tr>
<tr>
<th>381255</th>
<td>대덕전자주식회사</td>
<td>2351.00</td>
<td>2351.00</td>
<td>35.00</td>
<td>935602200.00</td>
<td>397959.25</td>
<td>4421769.46</td>
<td>53061233.52</td>
</tr>
<tr>
<th>191857</th>
<td>쿠팡 주식회사</td>
<td>12273.00</td>
<td>1514.00</td>
<td>691.00</td>
<td>3411985700.00</td>
<td>278007.47</td>
<td>3088971.91</td>
<td>37067662.89</td>
</tr>
<tr>
<th>381598</th>
<td>주식회사　세보엠이씨(일용)일반설비 1공구(3-1)</td>
<td>1429.00</td>
<td>1429.00</td>
<td>1.00</td>
<td>412810980.00</td>
<td>288881.02</td>
<td>3209789.13</td>
<td>38517469.56</td>
</tr>
<tr>
<th>393529</th>
<td>한국맥도날드유한회사(A)</td>
<td>8279.00</td>
<td>1359.00</td>
<td>1024.00</td>
<td>755471660.00</td>
<td>91251.56</td>
<td>1013906.22</td>
<td>12166874.58</td>
</tr>
<tr>
<th>65522</th>
<td>(주)제니엘</td>
<td>6187.00</td>
<td>927.00</td>
<td>517.00</td>
<td>1060803180.00</td>
<td>171456.79</td>
<td>1905075.48</td>
<td>22860905.77</td>
</tr>
<tr>
<th>379285</th>
<td>주식회사　세보엠이씨(일용)P2-하층서편 상층동편 기계배관공사(A)</td>
<td>728.00</td>
<td>728.00</td>
<td>2.00</td>
<td>209708900.00</td>
<td>288061.68</td>
<td>3200685.29</td>
<td>38408223.44</td>
</tr>
<tr>
<th>372037</th>
<td>인천공항경비주식회사</td>
<td>698.00</td>
<td>695.00</td>
<td>5.00</td>
<td>182957120.00</td>
<td>262116.22</td>
<td>2912402.42</td>
<td>34948829.04</td>
</tr>
<tr>
<th>481602</th>
<td>(주)세방테크-(일용)평택 FAB2기 신축공사 일반배관공사 3공구</td>
<td>1680.00</td>
<td>667.00</td>
<td>3.00</td>
<td>535126560.00</td>
<td>318527.71</td>
<td>3539196.83</td>
<td>42470361.90</td>
</tr>
<tr>
<th>441003</th>
<td>주식회사비케이알(버거킹)</td>
<td>3855.00</td>
<td>631.00</td>
<td>477.00</td>
<td>375317820.00</td>
<td>97358.71</td>
<td>1081763.42</td>
<td>12981161.09</td>
</tr>
<tr>
<th>382986</th>
<td>주식회사 유베이스</td>
<td>10159.00</td>
<td>620.00</td>
<td>770.00</td>
<td>1728395500.00</td>
<td>170134.41</td>
<td>1890382.36</td>
<td>22684588.38</td>
</tr>
<tr>
<th>2710</th>
<td>대한항공(주)</td>
<td>18176.00</td>
<td>613.00</td>
<td>119.00</td>
<td>7413092120.00</td>
<td>407850.58</td>
<td>4531673.10</td>
<td>54380077.17</td>
</tr>
<tr>
<th>46752</th>
<td>(유)아웃백스테이크하우스코리아</td>
<td>3165.00</td>
<td>582.00</td>
<td>194.00</td>
<td>478193620.00</td>
<td>151088.03</td>
<td>1678755.91</td>
<td>20145070.88</td>
</tr>
<tr>
<th>133634</th>
<td>(주)동서기공시화지점</td>
<td>569.00</td>
<td>569.00</td>
<td>6.00</td>
<td>202310260.00</td>
<td>355554.06</td>
<td>3950600.66</td>
<td>47407207.97</td>
</tr>
<tr>
<th>125680</th>
<td>진주시청</td>
<td>1121.00</td>
<td>554.00</td>
<td>67.00</td>
<td>175375900.00</td>
<td>156445.94</td>
<td>1738288.23</td>
<td>20859458.82</td>
</tr>
<tr>
<th>65776</th>
<td>SK브로드밴드(주)</td>
<td>2377.00</td>
<td>550.00</td>
<td>10.00</td>
<td>991576500.00</td>
<td>417154.61</td>
<td>4635051.18</td>
<td>55620614.22</td>
</tr>
<tr>
<th>379675</th>
<td>성남시청(성남형연대안전기금)</td>
<td>495.00</td>
<td>495.00</td>
<td>8.00</td>
<td>90607140.00</td>
<td>183044.73</td>
<td>2033830.30</td>
<td>24405963.64</td>
</tr>
<tr>
<th>75185</th>
<td>재단법인경기복지재단</td>
<td>575.00</td>
<td>490.00</td>
<td>489.00</td>
<td>114041260.00</td>
<td>198332.63</td>
<td>2203695.85</td>
<td>26444350.14</td>
</tr>
<tr>
<th>376271</th>
<td>대명지이씨（주）-(일용)평택 FAB2기 신축공사(하층서편)중 일반전기공사 3-2공구</td>
<td>479.00</td>
<td>479.00</td>
<td>0.00</td>
<td>121556600.00</td>
<td>253771.61</td>
<td>2819684.53</td>
<td>33836214.34</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="상실-King!">상실 King!</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="o">.</span><span class="n">sort_values</span><span class="p">(</span><span class="n">by</span><span class="o">=</span><span class="s1">'상실'</span><span class="p">,</span> <span class="n">ascending</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>사업장명</th>
<th>가입자수</th>
<th>신규</th>
<th>상실</th>
<th>고지금액</th>
<th>인당고지금액</th>
<th>평균월급</th>
<th>평균연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>313193</th>
<td>쿠팡풀필먼트서비스 유한회사</td>
<td>12164.00</td>
<td>4063.00</td>
<td>4602.00</td>
<td>602010580.00</td>
<td>49491.17</td>
<td>549901.88</td>
<td>6598822.54</td>
</tr>
<tr>
<th>394683</th>
<td>(주)교원구몬</td>
<td>2158.00</td>
<td>21.00</td>
<td>2071.00</td>
<td>709906460.00</td>
<td>328965.00</td>
<td>3655166.62</td>
<td>43861999.38</td>
</tr>
<tr>
<th>3453</th>
<td>하나투어(주)</td>
<td>2257.00</td>
<td>9.00</td>
<td>1841.00</td>
<td>638104980.00</td>
<td>282722.63</td>
<td>3141362.58</td>
<td>37696350.91</td>
</tr>
<tr>
<th>483834</th>
<td>중앙경찰학교(신임)</td>
<td>1857.00</td>
<td>0.00</td>
<td>1500.00</td>
<td>220149180.00</td>
<td>118550.99</td>
<td>1317233.17</td>
<td>15806798.06</td>
</tr>
<tr>
<th>257899</th>
<td>쿠팡풀필먼트서비스 유한회사</td>
<td>13791.00</td>
<td>2375.00</td>
<td>1079.00</td>
<td>2561355180.00</td>
<td>185726.57</td>
<td>2063628.60</td>
<td>24763543.18</td>
</tr>
<tr>
<th>393529</th>
<td>한국맥도날드유한회사(A)</td>
<td>8279.00</td>
<td>1359.00</td>
<td>1024.00</td>
<td>755471660.00</td>
<td>91251.56</td>
<td>1013906.22</td>
<td>12166874.58</td>
</tr>
<tr>
<th>494187</th>
<td>(주)이랜드이츠 압구정지점</td>
<td>4825.00</td>
<td>243.00</td>
<td>801.00</td>
<td>684444440.00</td>
<td>141853.77</td>
<td>1576153.00</td>
<td>18913835.99</td>
</tr>
<tr>
<th>382986</th>
<td>주식회사 유베이스</td>
<td>10159.00</td>
<td>620.00</td>
<td>770.00</td>
<td>1728395500.00</td>
<td>170134.41</td>
<td>1890382.36</td>
<td>22684588.38</td>
</tr>
<tr>
<th>351364</th>
<td>씨제이올리브영주식회사-비정규</td>
<td>3406.00</td>
<td>197.00</td>
<td>741.00</td>
<td>329764420.00</td>
<td>96818.68</td>
<td>1075763.10</td>
<td>12909157.17</td>
</tr>
<tr>
<th>191857</th>
<td>쿠팡 주식회사</td>
<td>12273.00</td>
<td>1514.00</td>
<td>691.00</td>
<td>3411985700.00</td>
<td>278007.47</td>
<td>3088971.91</td>
<td>37067662.89</td>
</tr>
<tr>
<th>65522</th>
<td>(주)제니엘</td>
<td>6187.00</td>
<td>927.00</td>
<td>517.00</td>
<td>1060803180.00</td>
<td>171456.79</td>
<td>1905075.48</td>
<td>22860905.77</td>
</tr>
<tr>
<th>3621</th>
<td>삼성전자(주)</td>
<td>103237.00</td>
<td>427.00</td>
<td>496.00</td>
<td>44035185740.00</td>
<td>426544.61</td>
<td>4739384.54</td>
<td>56872614.46</td>
</tr>
<tr>
<th>75185</th>
<td>재단법인경기복지재단</td>
<td>575.00</td>
<td>490.00</td>
<td>489.00</td>
<td>114041260.00</td>
<td>198332.63</td>
<td>2203695.85</td>
<td>26444350.14</td>
</tr>
<tr>
<th>441003</th>
<td>주식회사비케이알(버거킹)</td>
<td>3855.00</td>
<td>631.00</td>
<td>477.00</td>
<td>375317820.00</td>
<td>97358.71</td>
<td>1081763.42</td>
<td>12981161.09</td>
</tr>
<tr>
<th>46929</th>
<td>효성ITX (주)</td>
<td>7208.00</td>
<td>317.00</td>
<td>459.00</td>
<td>1325498120.00</td>
<td>183892.64</td>
<td>2043251.51</td>
<td>24519018.13</td>
</tr>
<tr>
<th>47300</th>
<td>주식회사 아성다이소</td>
<td>10895.00</td>
<td>275.00</td>
<td>459.00</td>
<td>1862925000.00</td>
<td>170988.99</td>
<td>1899877.62</td>
<td>22798531.44</td>
</tr>
<tr>
<th>9168</th>
<td>(주)트랜스코스모스코리아</td>
<td>7421.00</td>
<td>411.00</td>
<td>453.00</td>
<td>1276016220.00</td>
<td>171946.67</td>
<td>1910518.53</td>
<td>22926222.34</td>
</tr>
<tr>
<th>29201</th>
<td>(주) 티맥스데이터</td>
<td>458.00</td>
<td>6.00</td>
<td>450.00</td>
<td>176723080.00</td>
<td>385858.25</td>
<td>4287313.93</td>
<td>51447767.10</td>
</tr>
<tr>
<th>382999</th>
<td>(주)에스텍시스템</td>
<td>8697.00</td>
<td>326.00</td>
<td>445.00</td>
<td>1956266280.00</td>
<td>224935.76</td>
<td>2499286.19</td>
<td>29991434.29</td>
</tr>
<tr>
<th>299804</th>
<td>쿠팡로지스틱스서비스유한회사</td>
<td>460.00</td>
<td>151.00</td>
<td>434.00</td>
<td>28613620.00</td>
<td>62203.52</td>
<td>691150.24</td>
<td>8293802.90</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="300인-이하-기업">300인 이하 기업</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">people_limit</span> <span class="o">=</span> <span class="mi">300</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">small</span> <span class="o">=</span> <span class="n">df_main</span><span class="o">.</span><span class="n">loc</span><span class="p">[(</span><span class="n">df_main</span><span class="p">[</span><span class="s1">'가입자수'</span><span class="p">]</span><span class="o">.</span><span class="n">notnull</span><span class="p">())</span> <span class="o">&amp;</span> <span class="p">(</span><span class="n">df_main</span><span class="p">[</span><span class="s1">'가입자수'</span><span class="p">]</span> <span class="o">&lt;</span> <span class="n">people_limit</span><span class="p">)]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">small</span><span class="p">[</span><span class="s1">'가입자수'</span><span class="p">]</span><span class="o">.</span><span class="n">isnull</span><span class="p">()</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>
<span class="n">sns</span><span class="o">.</span><span class="n">distplot</span><span class="p">(</span><span class="n">small</span><span class="p">[</span><span class="s1">'가입자수'</span><span class="p">])</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'가입자'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">18</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">small</span><span class="o">.</span><span class="n">sort_values</span><span class="p">(</span><span class="n">by</span><span class="o">=</span><span class="s1">'상실'</span><span class="p">,</span> <span class="n">ascending</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>사업장명</th>
<th>가입자수</th>
<th>신규</th>
<th>상실</th>
<th>고지금액</th>
<th>인당고지금액</th>
<th>평균월급</th>
<th>평균연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>46903</th>
<td>(주)레스모아</td>
<td>260.00</td>
<td>9.00</td>
<td>233.00</td>
<td>60362400.00</td>
<td>232163.08</td>
<td>2579589.74</td>
<td>30955076.92</td>
</tr>
<tr>
<th>121422</th>
<td>아이에스동서(주)</td>
<td>228.00</td>
<td>0.00</td>
<td>228.00</td>
<td>94036000.00</td>
<td>412438.60</td>
<td>4582651.07</td>
<td>54991812.87</td>
</tr>
<tr>
<th>385579</th>
<td>하나투어리스트(주)</td>
<td>228.00</td>
<td>0.00</td>
<td>217.00</td>
<td>54604220.00</td>
<td>239492.19</td>
<td>2661024.37</td>
<td>31932292.40</td>
</tr>
<tr>
<th>92558</th>
<td>(재)광주경제고용진흥원</td>
<td>285.00</td>
<td>17.00</td>
<td>212.00</td>
<td>58959080.00</td>
<td>206873.96</td>
<td>2298599.61</td>
<td>27583195.32</td>
</tr>
<tr>
<th>507935</th>
<td>은평구청(2020.코로나19 극복지원단 사업)</td>
<td>210.00</td>
<td>210.00</td>
<td>210.00</td>
<td>25552800.00</td>
<td>121680.00</td>
<td>1352000.00</td>
<td>16224000.00</td>
</tr>
<tr>
<th>360785</th>
<td>유한회사기성</td>
<td>190.00</td>
<td>1.00</td>
<td>190.00</td>
<td>31669640.00</td>
<td>166682.32</td>
<td>1852025.73</td>
<td>22224308.77</td>
</tr>
<tr>
<th>92586</th>
<td>화신산업(주)</td>
<td>185.00</td>
<td>0.00</td>
<td>184.00</td>
<td>31676660.00</td>
<td>171225.19</td>
<td>1902502.10</td>
<td>22830025.23</td>
</tr>
<tr>
<th>274427</th>
<td>지에스아이(주)인천공항</td>
<td>182.00</td>
<td>0.00</td>
<td>182.00</td>
<td>38451780.00</td>
<td>211273.52</td>
<td>2347483.52</td>
<td>28169802.20</td>
</tr>
<tr>
<th>378584</th>
<td>달서구청/직장 (코로나19 긴급생계자금 지원)</td>
<td>179.00</td>
<td>179.00</td>
<td>179.00</td>
<td>27465840.00</td>
<td>153440.45</td>
<td>1704893.85</td>
<td>20458726.26</td>
</tr>
<tr>
<th>387164</th>
<td>국회사무처(회관인턴)</td>
<td>251.00</td>
<td>15.00</td>
<td>177.00</td>
<td>51253380.00</td>
<td>204196.73</td>
<td>2268852.59</td>
<td>27226231.08</td>
</tr>
<tr>
<th>381503</th>
<td>용인시청 시민안전담당관(경기도 재난기본소득 지급인력)</td>
<td>181.00</td>
<td>181.00</td>
<td>175.00</td>
<td>36135460.00</td>
<td>199643.43</td>
<td>2218260.28</td>
<td>26619123.39</td>
</tr>
<tr>
<th>377410</th>
<td>동구청/경제지원과(긴급생계)</td>
<td>191.00</td>
<td>191.00</td>
<td>172.00</td>
<td>30313460.00</td>
<td>158709.21</td>
<td>1763435.72</td>
<td>21161228.62</td>
</tr>
<tr>
<th>137126</th>
<td>달성군청 공공근로4단계</td>
<td>171.00</td>
<td>170.00</td>
<td>171.00</td>
<td>26784000.00</td>
<td>156631.58</td>
<td>1740350.88</td>
<td>20884210.53</td>
</tr>
<tr>
<th>270612</th>
<td>주식회사　두성시스템-T2 여객터미널(서) 환경미화용역</td>
<td>155.00</td>
<td>0.00</td>
<td>154.00</td>
<td>34814560.00</td>
<td>224610.06</td>
<td>2495667.38</td>
<td>29948008.60</td>
</tr>
<tr>
<th>154</th>
<td>아이에스동서(주)</td>
<td>202.00</td>
<td>1.00</td>
<td>143.00</td>
<td>71683720.00</td>
<td>354869.90</td>
<td>3942998.90</td>
<td>47315986.80</td>
</tr>
<tr>
<th>124796</th>
<td>아이에스동서(주) 진주지점</td>
<td>139.00</td>
<td>0.00</td>
<td>139.00</td>
<td>57925640.00</td>
<td>416731.22</td>
<td>4630346.92</td>
<td>55564163.07</td>
</tr>
<tr>
<th>421079</th>
<td>주식회사 평안운수</td>
<td>273.00</td>
<td>0.00</td>
<td>138.00</td>
<td>81341780.00</td>
<td>297955.24</td>
<td>3310613.76</td>
<td>39727365.08</td>
</tr>
<tr>
<th>63664</th>
<td>(주)제이알더블유</td>
<td>262.00</td>
<td>44.00</td>
<td>133.00</td>
<td>36343040.00</td>
<td>138713.89</td>
<td>1541265.48</td>
<td>18495185.75</td>
</tr>
<tr>
<th>331793</th>
<td>한전케이피에스（주）한빛3사업처/일용/원전 기전설비 경상 및 계획예방정비공사</td>
<td>130.00</td>
<td>7.00</td>
<td>130.00</td>
<td>24124500.00</td>
<td>185573.08</td>
<td>2061923.08</td>
<td>24743076.92</td>
</tr>
<tr>
<th>26837</th>
<td>대구광역시수성구청 일자리정책사업단</td>
<td>127.00</td>
<td>127.00</td>
<td>127.00</td>
<td>16600500.00</td>
<td>130712.60</td>
<td>1452362.20</td>
<td>17428346.46</td>
</tr>
<tr>
<th>46129</th>
<td>(주)세아네트웍스</td>
<td>166.00</td>
<td>0.00</td>
<td>126.00</td>
<td>57365180.00</td>
<td>345573.37</td>
<td>3839704.15</td>
<td>46076449.80</td>
</tr>
<tr>
<th>506549</th>
<td>경인지방통계청_일용</td>
<td>154.00</td>
<td>147.00</td>
<td>121.00</td>
<td>16557260.00</td>
<td>107514.68</td>
<td>1194607.50</td>
<td>14335290.04</td>
</tr>
<tr>
<th>494041</th>
<td>주식회사서울랜드서비스</td>
<td>126.00</td>
<td>31.00</td>
<td>120.00</td>
<td>26518400.00</td>
<td>210463.49</td>
<td>2338483.25</td>
<td>28061798.94</td>
</tr>
<tr>
<th>241524</th>
<td>대구시청/교육협력정책관</td>
<td>119.00</td>
<td>119.00</td>
<td>119.00</td>
<td>9135140.00</td>
<td>76765.88</td>
<td>852954.25</td>
<td>10235450.98</td>
</tr>
<tr>
<th>47506</th>
<td>대덕모듈(주)</td>
<td>120.00</td>
<td>1.00</td>
<td>119.00</td>
<td>42020680.00</td>
<td>350172.33</td>
<td>3890803.70</td>
<td>46689644.44</td>
</tr>
<tr>
<th>442408</th>
<td>(주)원피앤에스-인천공항</td>
<td>119.00</td>
<td>0.00</td>
<td>119.00</td>
<td>36676940.00</td>
<td>308209.58</td>
<td>3424550.89</td>
<td>41094610.64</td>
</tr>
<tr>
<th>487774</th>
<td>(주)화성건설이엔지-(일용)P2-PJT UT동 통합비계공사</td>
<td>109.00</td>
<td>16.00</td>
<td>109.00</td>
<td>30324980.00</td>
<td>278210.83</td>
<td>3091231.40</td>
<td>37094776.76</td>
</tr>
<tr>
<th>30939</th>
<td>(주)진명여객</td>
<td>152.00</td>
<td>11.00</td>
<td>108.00</td>
<td>44300660.00</td>
<td>291451.71</td>
<td>3238352.34</td>
<td>38860228.07</td>
</tr>
<tr>
<th>296952</th>
<td>(주)더이룸씨앤에스</td>
<td>113.00</td>
<td>12.00</td>
<td>106.00</td>
<td>12350340.00</td>
<td>109295.04</td>
<td>1214389.38</td>
<td>14572672.57</td>
</tr>
<tr>
<th>464092</th>
<td>주식회사비에이에스</td>
<td>218.00</td>
<td>1.00</td>
<td>103.00</td>
<td>40128160.00</td>
<td>184074.13</td>
<td>2045268.09</td>
<td>24543217.13</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>194402</th>
<td>(주)예푸드</td>
<td>4.00</td>
<td>0.00</td>
<td>0.00</td>
<td>512000.00</td>
<td>128000.00</td>
<td>1422222.22</td>
<td>17066666.67</td>
</tr>
<tr>
<th>194401</th>
<td>아이베란다주식회사</td>
<td>16.00</td>
<td>0.00</td>
<td>0.00</td>
<td>3277400.00</td>
<td>204837.50</td>
<td>2275972.22</td>
<td>27311666.67</td>
</tr>
<tr>
<th>194400</th>
<td>주식회사 매크로콤</td>
<td>4.00</td>
<td>0.00</td>
<td>0.00</td>
<td>1279800.00</td>
<td>319950.00</td>
<td>3555000.00</td>
<td>42660000.00</td>
</tr>
<tr>
<th>194431</th>
<td>(주)이앤에이텍</td>
<td>3.00</td>
<td>0.00</td>
<td>0.00</td>
<td>380340.00</td>
<td>126780.00</td>
<td>1408666.67</td>
<td>16904000.00</td>
</tr>
<tr>
<th>194432</th>
<td>서울시립청소년이동쉼터(동남권)</td>
<td>7.00</td>
<td>0.00</td>
<td>0.00</td>
<td>1478780.00</td>
<td>211254.29</td>
<td>2347269.84</td>
<td>28167238.10</td>
</tr>
<tr>
<th>194433</th>
<td>주식회사포엠</td>
<td>7.00</td>
<td>1.00</td>
<td>0.00</td>
<td>1639300.00</td>
<td>234185.71</td>
<td>2602063.49</td>
<td>31224761.90</td>
</tr>
<tr>
<th>194449</th>
<td>한국주택관리(주)세종한신휴플러스아파트</td>
<td>7.00</td>
<td>0.00</td>
<td>0.00</td>
<td>1855520.00</td>
<td>265074.29</td>
<td>2945269.84</td>
<td>35343238.10</td>
</tr>
<tr>
<th>194462</th>
<td>주식회사에이치케이공영</td>
<td>6.00</td>
<td>2.00</td>
<td>0.00</td>
<td>1431440.00</td>
<td>238573.33</td>
<td>2650814.81</td>
<td>31809777.78</td>
</tr>
<tr>
<th>194461</th>
<td>주식회사 야긴건영</td>
<td>3.00</td>
<td>0.00</td>
<td>0.00</td>
<td>707040.00</td>
<td>235680.00</td>
<td>2618666.67</td>
<td>31424000.00</td>
</tr>
<tr>
<th>194458</th>
<td>(주)우리플렉스</td>
<td>7.00</td>
<td>0.00</td>
<td>0.00</td>
<td>2420080.00</td>
<td>345725.71</td>
<td>3841396.83</td>
<td>46096761.90</td>
</tr>
<tr>
<th>194457</th>
<td>（주）프로젝터119</td>
<td>3.00</td>
<td>0.00</td>
<td>0.00</td>
<td>546740.00</td>
<td>182246.67</td>
<td>2024962.96</td>
<td>24299555.56</td>
</tr>
<tr>
<th>194456</th>
<td>침산태왕아너스로뎀관리사무소</td>
<td>4.00</td>
<td>0.00</td>
<td>0.00</td>
<td>781980.00</td>
<td>195495.00</td>
<td>2172166.67</td>
<td>26066000.00</td>
</tr>
<tr>
<th>194455</th>
<td>주식회사토탈테크놀러지</td>
<td>3.00</td>
<td>0.00</td>
<td>0.00</td>
<td>1312200.00</td>
<td>437400.00</td>
<td>4860000.00</td>
<td>58320000.00</td>
</tr>
<tr>
<th>194454</th>
<td>화성우리지역아동센터</td>
<td>4.00</td>
<td>0.00</td>
<td>0.00</td>
<td>492020.00</td>
<td>123005.00</td>
<td>1366722.22</td>
<td>16400666.67</td>
</tr>
<tr>
<th>194453</th>
<td>주식회사세명에스티</td>
<td>4.00</td>
<td>0.00</td>
<td>0.00</td>
<td>1576880.00</td>
<td>394220.00</td>
<td>4380222.22</td>
<td>52562666.67</td>
</tr>
<tr>
<th>194452</th>
<td>주식회사영광지엔티</td>
<td>3.00</td>
<td>0.00</td>
<td>0.00</td>
<td>833760.00</td>
<td>277920.00</td>
<td>3088000.00</td>
<td>37056000.00</td>
</tr>
<tr>
<th>194450</th>
<td>(주)범우디앤씨</td>
<td>3.00</td>
<td>0.00</td>
<td>0.00</td>
<td>604260.00</td>
<td>201420.00</td>
<td>2238000.00</td>
<td>26856000.00</td>
</tr>
<tr>
<th>194447</th>
<td>주식회사거원</td>
<td>12.00</td>
<td>0.00</td>
<td>0.00</td>
<td>3379360.00</td>
<td>281613.33</td>
<td>3129037.04</td>
<td>37548444.44</td>
</tr>
<tr>
<th>194434</th>
<td>주식회사삼진상사타이어</td>
<td>8.00</td>
<td>1.00</td>
<td>0.00</td>
<td>2086020.00</td>
<td>260752.50</td>
<td>2897250.00</td>
<td>34767000.00</td>
</tr>
<tr>
<th>194446</th>
<td>한국콘텐츠공제조합</td>
<td>7.00</td>
<td>0.00</td>
<td>0.00</td>
<td>2432500.00</td>
<td>347500.00</td>
<td>3861111.11</td>
<td>46333333.33</td>
</tr>
<tr>
<th>194445</th>
<td>경보환경(주)</td>
<td>5.00</td>
<td>0.00</td>
<td>0.00</td>
<td>736280.00</td>
<td>147256.00</td>
<td>1636177.78</td>
<td>19634133.33</td>
</tr>
<tr>
<th>194444</th>
<td>(사)서울경제인협회</td>
<td>3.00</td>
<td>1.00</td>
<td>0.00</td>
<td>657080.00</td>
<td>219026.67</td>
<td>2433629.63</td>
<td>29203555.56</td>
</tr>
<tr>
<th>194442</th>
<td>주식회사맑음</td>
<td>7.00</td>
<td>0.00</td>
<td>0.00</td>
<td>1127040.00</td>
<td>161005.71</td>
<td>1788952.38</td>
<td>21467428.57</td>
</tr>
<tr>
<th>194441</th>
<td>（주）에브리코리아</td>
<td>5.00</td>
<td>2.00</td>
<td>0.00</td>
<td>1011140.00</td>
<td>202228.00</td>
<td>2246977.78</td>
<td>26963733.33</td>
</tr>
<tr>
<th>194440</th>
<td>나섬자산운용주식회사</td>
<td>7.00</td>
<td>0.00</td>
<td>0.00</td>
<td>2252880.00</td>
<td>321840.00</td>
<td>3576000.00</td>
<td>42912000.00</td>
</tr>
<tr>
<th>194439</th>
<td>복원이엔씨 주식회사</td>
<td>3.00</td>
<td>0.00</td>
<td>0.00</td>
<td>681480.00</td>
<td>227160.00</td>
<td>2524000.00</td>
<td>30288000.00</td>
</tr>
<tr>
<th>194438</th>
<td>주식회사동명기공</td>
<td>4.00</td>
<td>0.00</td>
<td>0.00</td>
<td>1149640.00</td>
<td>287410.00</td>
<td>3193444.44</td>
<td>38321333.33</td>
</tr>
<tr>
<th>194436</th>
<td>주식회사로드랜드건설</td>
<td>13.00</td>
<td>0.00</td>
<td>0.00</td>
<td>3289340.00</td>
<td>253026.15</td>
<td>2811401.71</td>
<td>33736820.51</td>
</tr>
<tr>
<th>194435</th>
<td>(주)플랫콘</td>
<td>4.00</td>
<td>0.00</td>
<td>0.00</td>
<td>1216800.00</td>
<td>304200.00</td>
<td>3380000.00</td>
<td>40560000.00</td>
</tr>
<tr>
<th>254943</th>
<td>(주)효신 제2공장</td>
<td>10.00</td>
<td>1.00</td>
<td>0.00</td>
<td>2439540.00</td>
<td>243954.00</td>
<td>2710600.00</td>
<td>32527200.00</td>
</tr>
</tbody>
</table>
<p>505892 rows × 8 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="사업장명-데이터-정제-(Cleansing)">사업장명 데이터 정제 (Cleansing)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">re</span>

<span class="c1"># 괄호안 문자열 제거</span>
<span class="n">pattern_1</span> <span class="o">=</span> <span class="s1">'\(.*\)'</span>
<span class="n">pattern_2</span> <span class="o">=</span> <span class="s1">'\（.*\）'</span>
<span class="n">pattern_3</span> <span class="o">=</span> <span class="s1">'주식회사'</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="(주),-(주식회사)-문자열-제거">(주), (주식회사) 문자열 제거</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_1</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="s1">'브레인크루(주)'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'브레인크루'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_1</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="s1">'브레인크루(주식회사)'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'브레인크루'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_1</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="s1">'(주)브레인크루'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'브레인크루'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_2</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="s1">'（주）타워홀딩스'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'타워홀딩스'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="주식회사-문자열-제거">주식회사 문자열 제거</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_2</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="s1">'브레인크루 주식회사'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'브레인크루 주식회사'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_2</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="s1">'브레인크루주식회사'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'브레인크루주식회사'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_2</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="s1">'주식회사브레인크루주식회사'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'주식회사브레인크루주식회사'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">text_preprocess</span><span class="p">(</span><span class="n">text</span><span class="p">):</span>
    <span class="n">text</span> <span class="o">=</span> <span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_1</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="n">text</span><span class="p">)</span>
    <span class="n">text</span> <span class="o">=</span> <span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_2</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="n">text</span><span class="p">)</span>
    <span class="n">text</span> <span class="o">=</span> <span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="n">pattern_3</span><span class="p">,</span> <span class="s1">''</span><span class="p">,</span> <span class="n">text</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">text</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="s1">'사업장명'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df_main</span><span class="p">[</span><span class="s1">'사업장명'</span><span class="p">]</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="n">text_preprocess</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_main</span><span class="p">[</span><span class="n">df_main</span><span class="p">[</span><span class="s1">'사업장명'</span><span class="p">]</span> <span class="o">==</span> <span class="s1">'패스트캠퍼스'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>사업장명</th>
<th>가입자수</th>
<th>신규</th>
<th>상실</th>
<th>고지금액</th>
<th>인당고지금액</th>
<th>평균월급</th>
<th>평균연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>268632</th>
<td>패스트캠퍼스</td>
<td>120.00</td>
<td>6.00</td>
<td>8.00</td>
<td>31263860.00</td>
<td>260532.17</td>
<td>2894801.85</td>
<td>34737622.22</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'사업장명'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s1">'사업장명'</span><span class="p">]</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="n">text_preprocess</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">columns</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>Index(['자료생성년월', '사업장명', '사업자번호', '가입상태', '우편번호', '지번주소', '도로명주소', '법정주소코드',
       '행정주소코드', '광역시코드', '시군구코드', '읍면동코드', '사업장형태', '업종코드', '업종코드명', '적용일',
       '재등록일', '탈퇴일', '가입자수', '고지금액', '신규', '상실', '인당고지금액', '평균월급', '평균연봉'],
      dtype='object')</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">16</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">sns</span><span class="o">.</span><span class="n">barplot</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'시군구코드'</span><span class="p">)[</span><span class="s1">'가입자수'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span><span class="o">.</span><span class="n">index</span><span class="p">,</span> <span class="n">y</span><span class="o">=</span><span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'시군구코드'</span><span class="p">)[</span><span class="s1">'가입자수'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">())</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'시군구 별 가입자수'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xticks</span><span class="p">(</span><span class="n">rotation</span><span class="o">=</span><span class="mi">90</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">16</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">sns</span><span class="o">.</span><span class="n">barplot</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'시군구코드'</span><span class="p">)[</span><span class="s1">'신규'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span><span class="o">.</span><span class="n">index</span><span class="p">,</span> <span class="n">y</span><span class="o">=</span><span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'시군구코드'</span><span class="p">)[</span><span class="s1">'신규'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">())</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'시군구 별 신규인력'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xticks</span><span class="p">(</span><span class="n">rotation</span><span class="o">=</span><span class="mi">90</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">16</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">sns</span><span class="o">.</span><span class="n">barplot</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'시군구코드'</span><span class="p">)[</span><span class="s1">'상실'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span><span class="o">.</span><span class="n">index</span><span class="p">,</span> <span class="n">y</span><span class="o">=</span><span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'시군구코드'</span><span class="p">)[</span><span class="s1">'상실'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">())</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'시군구 별 신규인력'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xticks</span><span class="p">(</span><span class="n">rotation</span><span class="o">=</span><span class="mi">90</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>자료생성년월</th>
<th>사업장명</th>
<th>사업자번호</th>
<th>가입상태</th>
<th>우편번호</th>
<th>지번주소</th>
<th>도로명주소</th>
<th>법정주소코드</th>
<th>행정주소코드</th>
<th>광역시코드</th>
<th>...</th>
<th>적용일</th>
<th>재등록일</th>
<th>탈퇴일</th>
<th>가입자수</th>
<th>고지금액</th>
<th>신규</th>
<th>상실</th>
<th>인당고지금액</th>
<th>평균월급</th>
<th>평균연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>202005.00</td>
<td>니프코코리아</td>
<td>211814.00</td>
<td>1.00</td>
<td>31409.00</td>
<td>충청남도 아산시 둔포면</td>
<td>충청남도 아산시 둔포면 아산밸리남로</td>
<td>4420036032.00</td>
<td>4420036032</td>
<td>44.00</td>
<td>...</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>625.00</td>
<td>263793840.00</td>
<td>0.00</td>
<td>3.00</td>
<td>422070.14</td>
<td>4689668.27</td>
<td>56276019.20</td>
</tr>
<tr>
<th>1</th>
<td>202005.00</td>
<td>글로웨이</td>
<td>110812.00</td>
<td>1.00</td>
<td>6072.00</td>
<td>서울특별시 강남구 청담동</td>
<td>서울특별시 강남구 영동대로137길</td>
<td>1168010400.00</td>
<td>1168056500</td>
<td>11.00</td>
<td>...</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>3.00</td>
<td>1099960.00</td>
<td>0.00</td>
<td>0.00</td>
<td>366653.33</td>
<td>4073925.93</td>
<td>48887111.11</td>
</tr>
<tr>
<th>2</th>
<td>202005.00</td>
<td>신일기업</td>
<td>201810.00</td>
<td>1.00</td>
<td>4537.00</td>
<td>서울특별시 중구 충무로2가</td>
<td>서울특별시 중구 퇴계로</td>
<td>1114012500.00</td>
<td>1114055000</td>
<td>11.00</td>
<td>...</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>18.00</td>
<td>5954520.00</td>
<td>0.00</td>
<td>0.00</td>
<td>330806.67</td>
<td>3675629.63</td>
<td>44107555.56</td>
</tr>
<tr>
<th>3</th>
<td>202005.00</td>
<td>디에스디엘</td>
<td>104811.00</td>
<td>1.00</td>
<td>4526.00</td>
<td>서울특별시 중구 남대문로4가</td>
<td>서울특별시 중구 세종대로</td>
<td>1114011700.00</td>
<td>1114054000</td>
<td>11.00</td>
<td>...</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>19.00</td>
<td>4064440.00</td>
<td>0.00</td>
<td>2.00</td>
<td>213917.89</td>
<td>2376865.50</td>
<td>28522385.96</td>
</tr>
<tr>
<th>4</th>
<td>202005.00</td>
<td>헤럴드</td>
<td>104810.00</td>
<td>1.00</td>
<td>4336.00</td>
<td>서울특별시 용산구 후암동</td>
<td>서울특별시 용산구 후암로4길</td>
<td>1117010100.00</td>
<td>1117051000</td>
<td>11.00</td>
<td>...</td>
<td>19880101.00</td>
<td>10101.00</td>
<td>10101.00</td>
<td>305.00</td>
<td>108148760.00</td>
<td>4.00</td>
<td>2.00</td>
<td>354586.10</td>
<td>3939845.54</td>
<td>47278146.45</td>
</tr>
</tbody>
</table>
<p>5 rows × 25 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="신규-인력이-많은-시군구코드">신규 인력이 많은 시군구코드</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>경기도 평택시</strong>에서 최근 국민연금 가입자 신규인력이 가장 많이 발생했음</p>
<p>주로 건축 인력 혹은 건설사 인력들이 신규로 편입되면서 국민연금 가입자 발생이 가장 많이 일어난 것으로 집계 됐다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">df</span><span class="p">[</span><span class="s1">'시군구코드'</span><span class="p">]</span> <span class="o">==</span> <span class="mi">220</span><span class="p">][[</span><span class="s1">'사업장명'</span><span class="p">,</span><span class="s1">'지번주소'</span><span class="p">,</span><span class="s1">'신규'</span><span class="p">]]</span><span class="o">.</span><span class="n">sort_values</span><span class="p">(</span><span class="n">by</span><span class="o">=</span><span class="s1">'신규'</span><span class="p">,</span> <span class="n">ascending</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>사업장명</th>
<th>지번주소</th>
<th>신규</th>
</tr>
</thead>
<tbody>
<tr>
<th>381598</th>
<td>세보엠이씨</td>
<td>경기도 평택시 고덕면</td>
<td>1429.00</td>
</tr>
<tr>
<th>379285</th>
<td>세보엠이씨</td>
<td>경기도 평택시 고덕면</td>
<td>728.00</td>
</tr>
<tr>
<th>481602</th>
<td>평택 FAB2기 신축공사 일반배관공사 3공구</td>
<td>경기도 평택시 고덕면</td>
<td>667.00</td>
</tr>
<tr>
<th>376271</th>
<td>대명지이씨-중 일반전기공사 3-2공구</td>
<td>경기도 평택시 고덕면</td>
<td>479.00</td>
</tr>
<tr>
<th>374752</th>
<td>두원이에프씨 중 일반전기공사 2-1공구</td>
<td>경기도 평택시 고덕면</td>
<td>388.00</td>
</tr>
<tr>
<th>376048</th>
<td>세안이엔씨-일반전기공사 2-2공구</td>
<td>경기도 평택시 고덕면</td>
<td>383.00</td>
</tr>
<tr>
<th>508716</th>
<td>신보- 일반전기공사 2-3공구</td>
<td>경기도 평택시 고덕면</td>
<td>377.00</td>
</tr>
<tr>
<th>508047</th>
<td>중 일반전기공사 3-1 공구</td>
<td>경기도 평택시 장당동</td>
<td>370.00</td>
</tr>
<tr>
<th>319427</th>
<td>한양이엔지-평택 FAB 2기 신축공사 일반배관공사 7공구</td>
<td>경기도 평택시 고덕면</td>
<td>365.00</td>
</tr>
<tr>
<th>380824</th>
<td>대아이앤씨-평택FAB2기신축공사 중 하층서편  상층동편 공사 중 일반설비6공구</td>
<td>경기도 평택시 고덕면</td>
<td>325.00</td>
</tr>
<tr>
<th>372788</th>
<td>우현이앤지-</td>
<td>경기도 평택시 장당동</td>
<td>287.00</td>
</tr>
<tr>
<th>507319</th>
<td>삼호이앤에프-평택 소방전기공사 2-1공구</td>
<td>경기도 평택시 고덕면</td>
<td>282.00</td>
</tr>
<tr>
<th>503876</th>
<td>존슨콘트롤즈인터내셔널코리아평택 전자 P2-PJT UT동 하층서편_소방설비공사</td>
<td>경기도 평택시 고덕면</td>
<td>245.00</td>
</tr>
<tr>
<th>320587</th>
<td>케이씨이앤씨-평택FAB 2기 신축공사 중 GAS 1공구공사</td>
<td>경기도 평택시 고덕면</td>
<td>189.00</td>
</tr>
<tr>
<th>373826</th>
<td></td>
<td>경기도 평택시 고덕면</td>
<td>187.00</td>
</tr>
<tr>
<th>376168</th>
<td></td>
<td>경기도 평택시 장당동</td>
<td>164.00</td>
</tr>
<tr>
<th>377575</th>
<td>에이치케이안전시스템</td>
<td>경기도 평택시 고덕면</td>
<td>153.00</td>
</tr>
<tr>
<th>361837</th>
<td>평택 지제세교지구 1블록 공동주택</td>
<td>경기도 평택시 지제동</td>
<td>152.00</td>
</tr>
<tr>
<th>380130</th>
<td>세보엠이씨</td>
<td>경기도 평택시 장당동</td>
<td>143.00</td>
</tr>
<tr>
<th>376504</th>
<td></td>
<td>경기도 평택시 고덕면</td>
<td>135.00</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>서울특별시 영등포구</strong>에서 가장 많은 상실 인력이 발생했다.</p>
<p>하지만, 효성ITX, 엘지전자와 같이 굵직한 기업들이 인력 감소를 함으로써 <strong>본 주소인 영등포구 에서 상실 인력</strong>이 많이 발생한 것으로 집계됐다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">df</span><span class="p">[</span><span class="s1">'시군구코드'</span><span class="p">]</span> <span class="o">==</span> <span class="mi">560</span><span class="p">][[</span><span class="s1">'사업장명'</span><span class="p">,</span><span class="s1">'지번주소'</span><span class="p">,</span><span class="s1">'상실'</span><span class="p">]]</span><span class="o">.</span><span class="n">sort_values</span><span class="p">(</span><span class="n">by</span><span class="o">=</span><span class="s1">'상실'</span><span class="p">,</span> <span class="n">ascending</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>사업장명</th>
<th>지번주소</th>
<th>상실</th>
</tr>
</thead>
<tbody>
<tr>
<th>46929</th>
<td>효성ITX</td>
<td>서울특별시 영등포구 양평동4가</td>
<td>459.00</td>
</tr>
<tr>
<th>60558</th>
<td>윌앤비전</td>
<td>서울특별시 영등포구 당산동4가</td>
<td>222.00</td>
</tr>
<tr>
<th>11133</th>
<td>엘지전자</td>
<td>서울특별시 영등포구 여의도동</td>
<td>202.00</td>
</tr>
<tr>
<th>384806</th>
<td>케이티아이에스</td>
<td>서울특별시 영등포구 여의도동</td>
<td>178.00</td>
</tr>
<tr>
<th>387164</th>
<td>국회사무처</td>
<td>서울특별시 영등포구 여의도동</td>
<td>177.00</td>
</tr>
<tr>
<th>859</th>
<td>한화손해보험</td>
<td>서울특별시 영등포구 여의도동</td>
<td>169.00</td>
</tr>
<tr>
<th>382074</th>
<td>한국피자헛 유한회사</td>
<td>서울특별시 영등포구 여의도동</td>
<td>123.00</td>
</tr>
<tr>
<th>382702</th>
<td>인터비즈시스템</td>
<td>서울특별시 영등포구 여의도동</td>
<td>116.00</td>
</tr>
<tr>
<th>130001</th>
<td>엘지디스플레이</td>
<td>서울특별시 영등포구 여의도동</td>
<td>115.00</td>
</tr>
<tr>
<th>46933</th>
<td>한성엠에스</td>
<td>서울특별시 영등포구 양평동3가</td>
<td>99.00</td>
</tr>
<tr>
<th>517</th>
<td>제이앤비컨설팅</td>
<td>서울특별시 영등포구 문래동3가</td>
<td>93.00</td>
</tr>
<tr>
<th>38799</th>
<td>조은시스템</td>
<td>서울특별시 영등포구 문래동3가</td>
<td>93.00</td>
</tr>
<tr>
<th>245573</th>
<td>아임파워-현장</td>
<td>서울특별시 영등포구 문래동6가</td>
<td>89.00</td>
</tr>
<tr>
<th>56232</th>
<td>미성엠프로</td>
<td>서울특별시 영등포구 당산동3가</td>
<td>87.00</td>
</tr>
<tr>
<th>1413</th>
<td>고암</td>
<td>서울특별시 영등포구 당산동6가</td>
<td>80.00</td>
</tr>
<tr>
<th>402296</th>
<td>우림맨테크</td>
<td>서울특별시 영등포구 양평동3가</td>
<td>76.00</td>
</tr>
<tr>
<th>399161</th>
<td>현대캐피탈</td>
<td>서울특별시 영등포구 여의도동</td>
<td>75.00</td>
</tr>
<tr>
<th>394411</th>
<td>에프에이모스트</td>
<td>서울특별시 영등포구 양평동3가</td>
<td>74.00</td>
</tr>
<tr>
<th>22537</th>
<td>반도티에스</td>
<td>서울특별시 영등포구 당산동6가</td>
<td>72.00</td>
</tr>
<tr>
<th>382436</th>
<td>국민은행</td>
<td>서울특별시 영등포구 여의도동</td>
<td>71.00</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="업종별-신규-인력-현황">업종별 신규 인력 현황</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'업종코드명'</span><span class="p">)[</span><span class="s1">'신규'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>업종코드명
1차 금속제품 도매업                       0.15
BIZ_NO미존재사업장                      0.45
가공 및 정제염 제조업                      0.05
가구 내 고용활동                         1.33
가구 소매업                            0.22
가금류 가공 및 저장 처리업                   0.61
가금류 가공 및 저장 처리업 / 육류 포장육 및 냉동육    0.54
가금류 도축업                           2.00
가발 및 유사 제품 제조업                    0.12
가방 및 기타 가죽제품 소매업                  0.68
가방 및 기타 보호용 케이스 제조업               0.25
가방 및 보호용 케이스 도매업                  0.47
가수                                0.00
가스집단공급업                           0.21
가전제품 및 부품 도매업                     0.37
가전제품 소매업                          0.39
가전제품 수리업                          0.65
가정용 가스 연료 소매업                     0.18
가정용 고체 연료 소매업                     0.67
가정용 및 장식용 도자기 제조업                 0.29
가정용 비전기식 조리 및 난방 기구 제조업           0.46
가정용 세탁업                           0.30
가정용 액체 연료 소매업                     0.35
가정용 유리제품 제조업                      0.39
가정용 전기 난방기기 제조업                   5.00
가정용 직물제품 소매업                      0.00
가죽 및 모피 의복 소매업                    0.67
가죽 및 모피 제품 도매업                    0.55
가죽의복 제조업                          0.43
간이 음식 포장 판매 전문점                   0.52
                                  ... 
항공 및 육상 화물 취급업                    0.79
항공 여객 운송업                         8.88
항공기용 부품 제조업                       0.48
항만  수로  댐 및 유사 구조물 건설업            0.00
해수면 양식 어업                         0.36
핵반응기 및 증기보일러 제조업                  0.84
핸드백 및 지갑 제조업                      2.00
행사도우미                             0.15
호스팅 및 관련 서비스업                     1.33
호텔업                               0.74
혼성 및 재생 플라스틱 소재 물질 제조업            0.60
화가 및 관련예술가                        0.69
화물 운송 중개  대리 및 관련 서비스업            0.29
화물 자동차 및 특수 목적용 자동차 제조업           2.21
화물 포장  검수 및 계량 서비스업              38.91
화약 및 불꽃제품 제조업                     2.00
화장터 운영  묘지 분양 및 관리업               0.37
화장품  비누 및 방향제 소매업                 0.49
화장품 및 화장용품 도매업                    0.48
화장품 제조업                           1.21
화초 및 식물 소매업                       0.35
화학 살균ㆍ살충제 및 농업용 약제 제조업            1.35
화학섬유 방적업                          0.21
화학섬유직물 직조업                        0.16
화학용 및 비료 원료용 광물 광업                0.00
화훼류 및 식물 도매업                      0.32
화훼작물 재배업                          0.00
환경 관련 엔지니어링 서비스업                  0.70
환경설비 건설업                          0.44
휴양 콘도 운영업                         0.70
Name: 신규, Length: 1121, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_1</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'업종코드명'</span><span class="p">)[</span><span class="s1">'신규'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_1</span><span class="o">.</span><span class="n">sort_values</span><span class="p">(</span><span class="n">ascending</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span><span class="o">.</span><span class="n">count</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>1121</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>총 출력할 갯수(업종=1121개)가 너무 많다...ㅠ</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>상위 50 개 <strong>업종</strong> 출력하도록 하겠습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_top100</span> <span class="o">=</span> <span class="n">df_1</span><span class="o">.</span><span class="n">sort_values</span><span class="p">(</span><span class="n">ascending</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">(</span><span class="mi">50</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">16</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">sns</span><span class="o">.</span><span class="n">barplot</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">df_top100</span><span class="o">.</span><span class="n">index</span><span class="p">,</span> <span class="n">y</span><span class="o">=</span><span class="n">df_top100</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'업종별 신규인력'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xticks</span><span class="p">(</span><span class="n">rotation</span><span class="o">=</span><span class="mi">90</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>코로나 바이러스 이전 사태와는 면밀한 비교를 위하여 이전 데이터가 필요합니다.</li>
<li>하지만, 포스트 코로나 현상황에서는 <strong>음료품배달업, 포장 검수 및 계량 서비스업, 수산동물 훈제 조리 및 유사 조제식품 제조업</strong> 순으로 채용이 증가되었음을 확인할 수 있습니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_2</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'업종코드명'</span><span class="p">)[</span><span class="s1">'상실'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_bot100</span> <span class="o">=</span> <span class="n">df_2</span><span class="o">.</span><span class="n">sort_values</span><span class="p">(</span><span class="n">ascending</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">(</span><span class="mi">50</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">16</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">sns</span><span class="o">.</span><span class="n">barplot</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">df_bot100</span><span class="o">.</span><span class="n">index</span><span class="p">,</span> <span class="n">y</span><span class="o">=</span><span class="n">df_bot100</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'업종별 상실인력'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xticks</span><span class="p">(</span><span class="n">rotation</span><span class="o">=</span><span class="mi">90</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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SqKoIZB0AHAJ8DCwLnCI7dn1RhUREREREdE86dQOgaTlgIdtP1B3LBEREREREU2WTm1ERERERERMWUkUFREREREREVNWEkUNmKQjmH9N2u8Au9redQJDioiIiIiIaKxMPx4wSa/tOLQscC/w38AmwBm2XzHhgUVERERERDRQph8PmO0LgEXatjcH/gncb/vOOmOLiIiIiIhomkw/HjBJBwErA4tL2hi4DXgGsHedcUVERERERDRROrWDt77tV0uaSalVezywI3C1pOuY/3rbiIiIiIiI6FGmHw/ezOqx9Xf7GPAw8CCwNrB4HUFFREREREQ0UUZqB+/Hkn4FLAx8jzIy+2vgOsqI7RU1xhYREREREdEoyX48BJKeBzxu+3pJHwJm2v6fuuOKiIiIiIhomnRqh0TSa4DfU6YdY3t2vRFFREREREQ0T9bUDs97gBVtz27v0Epao8aYIiIiIiIiGiUjtQMm6S+UdbQzgTmMZDv+he3dJF1qe73aAoyIiIiIiGiQJIoaMNtrSlrJ9i0Akr5m+1NtL1FNoUVERERERDROph8PxxWStpL0JmCLjucyNB4RERERETEgGakdjmWAlwKLAEvUHEtERERERERjpVM7HL+xvT+ULMiSBGwMLA8sXWdgERERERERTZJO7XCsL+lM4N+AtSnraNcCng2cUmNcERERERERjZLsx0Mg6Q/A64HZwE+BDW3PqTeqiIiIiIiI5kmndsgkrW77r3XHERERERER0UTp1A5YW53aVumeJ/0F215rQoOKiIiIiIhoqHRqJ4ikpYBNbf+47lgiIiIiIiKaInVqh0DSTEkflnSwpI2qw7OB7eqMKyIiIiIiomnSqR2ObwErAT8HDpD0CtsPAkvVG1ZERERERESzpKTPcLzQ9i4Akv4J/EDS34Cn1RpVREREREREw2SkdjhmSFq22l4bOBrYAXiotogiIiIiIiIaKCO1w7E38OtqlPZBYEvbD0tKrdqIiIiIiIgBSqd2CGyfK+m5wDK2/9H21C11xRQREREREdFEKekTERERERERU1ZGagdM0jlA552CA4F/B5YAsP36iY4rIiIiIiKiiTJSO2CSVgUE/BR4C7AwcBvwS+BtALb/XluAERERERERDZKR2gFrdVglnUlZQ3ua7TdKejyd2YiIiIiIiMFKSZ8hkHQTcAfwFeCQmsOJiIiIiIhorHRqh+M24KnAKrbPrI5lnndERERERMSApVM7HI/b3h+4RtK7qmOqM6CIiIiIiIgmSqKoIZB0ie0NJC0M/AJ4PbCc7ZtqDi0iIiIiIqJRMlI7HB8EsD0b+DawbDq0ERERERERg5eR2gGTdB7zrp9V274A2950wgOLiIiIiIhooHRqB0zSSq1N4DTgzZ2vsX3LhAYVERERERHRUJl+PGC2b6l+ZlESRt0CzAF2aT1Xc4gRERERERGNkU7tcL1D0jLAj4Gz6w4mIiIiIiKiaRaqO4AmkvRZ4B/AU4AtgN1tX15vVBEREREREc2TTu1w3AssC2wKzAQeqTeciIiIiIiIZkqiqCGTtCZwNLCf7XNqDiciIiIiIqJR0qmdAJKeCpwEbGV7Tt3xRERERERENEU6tRERERERETFlJftxRERERERETFnp1EZERERERMSUlU5tRERERERETFnp1EZERAyBpM9I+p2kSyW9sTq2sqTzaw4NAEnflbRx3XFERESMV+rURkREDJikFwNvAF4JLAZcJOnnHa/ZC9i62jWwKvBL29u0vebwqo12zwFeZfu66jX/C6xBR0102y+vnj8fWBJ4FFgOEHBrdc5x4/yjRkRE1C6d2oiIiMFbC7jE9hPAA5JuBi4H5gD3ANg+UNK3gE2BtwBPBfZub8T27p0NS/oZ8K+Ow++x/YcFxPN223+TtD2wlO2Dq98dEREx5aVTGxERMXiXAZ+V9A1gGWBt4IXA04HjJC0FHETpnP4cuB44FNhV0tOBXW0/Iekk4BlVmzOBx4GXAHeNI7ZPSPoAZWT4pHG0ExERMSmkUxsRETFgtm+U9EXgBOAJ4P22H5K0KHABsD5wctspe1JGcs+t9tep9j9ImS68FvAH23MkXWH70Y5feYqkRzqOvc723cBNwA8lzQEWAT5v+1hJ3x3YHzgiIqJGsl13DBEREY0k6STb72nbXwb4GnDVGKf+1fapbef9zfazJS0J/Mz2RgOI7W3AVbZvHG9bERER1myTlgAAAVFJREFUdUqnNiIiYkgk/ZWSlKllYeBh2xtLegqwH/Dy6rk5wBnA191xcW7r1C4KPNP2X3uMYwXgvylTjqFMZT7G9uG9/pkiIiImm0w/joiIGJ7HbG/Y2pH0DEbWsX4ZuIMyTXiOpH8DjgK2BY6V9Ou2dlZs35cEcDrwpjF+/wG2T6es3/2Z7eOq8xcF/k/SZbZ/vcAWIiIiJrl0aiMiIoZnEUm/a9tfCLi32r6LMnK6gqS7gFWAFarj2F6/i/YP6DKOO4AXS1qWkpxqLWBpqkzMERERU1mmH0dERNRA0gxgJ0o926WB24CTbP9sCL9rEeAjwCaU0kF/B46w/ctB/66IiIiJlk5tRERERERETFkz6g4gIiIiIiIiol/p1EZERERERMSUlU5tRERERERETFnp1EZERERERMSUlU5tRERERERETFnp1EZERERERMSU9f8Bgme9MoWjIcsAAAAASUVORK5CYII=
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>업종별 상실 인력에 대한 <strong>TOP 50 결과</strong>입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>여기서 재밌는 점은, 이전에 신규인력이 가장 많은 업종도 <strong>음료품배달원</strong> 이었다는 점입니다.</p>
<p>좀 더 구체적인 데이터를 통해서 신규와 상실이 동시에 많이 일어난 이유에 대한 분석이 면밀히 필요합니다.</p>
<p>때론, 한 기업이 M&amp;A를 진행된 후 타 회사로 인력이 <strong>상실 -&gt; 편입 되면서 데이터 인사이트에 대한 왜곡 현상</strong>이 생길 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="업종별-단일-회사-연봉-비교-차트-그리기">업종별 단일 회사 연봉 비교 차트 그리기</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">compare_and_visualize</span><span class="p">(</span><span class="n">company</span><span class="p">):</span>
    <span class="n">code</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="n">df</span><span class="p">[</span><span class="s1">'사업장명'</span><span class="p">]</span> <span class="o">==</span> <span class="n">company</span><span class="p">][</span><span class="s1">'업종코드'</span><span class="p">]</span>
    <span class="n">cols</span> <span class="o">=</span> <span class="p">[</span><span class="s1">'가입자수'</span><span class="p">,</span> <span class="s1">'평균월급'</span><span class="p">,</span> <span class="s1">'평균연봉'</span><span class="p">,</span> <span class="s1">'신규'</span><span class="p">,</span> <span class="s1">'상실'</span><span class="p">,</span> <span class="s1">'업종코드'</span><span class="p">]</span>
    <span class="n">filtered</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">df</span><span class="p">[</span><span class="s1">'업종코드'</span><span class="p">]</span><span class="o">==</span><span class="n">code</span><span class="o">.</span><span class="n">item</span><span class="p">()][</span><span class="n">cols</span><span class="p">]</span>
    <span class="n">df_company</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">df</span><span class="p">[</span><span class="s1">'사업장명'</span><span class="p">]</span> <span class="o">==</span> <span class="n">company</span><span class="p">][</span><span class="n">cols</span><span class="p">]</span>
    <span class="n">df_company</span> <span class="o">=</span> <span class="n">df_company</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">pd</span><span class="o">.</span><span class="n">Series</span><span class="p">(</span><span class="n">filtered</span><span class="o">.</span><span class="n">mean</span><span class="p">()),</span> <span class="n">ignore_index</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
    
    <span class="n">compare_cols</span> <span class="o">=</span> <span class="p">[</span><span class="s1">'가입자수'</span><span class="p">,</span> <span class="s1">'평균월급'</span><span class="p">,</span> <span class="s1">'평균연봉'</span><span class="p">,</span> <span class="s1">'신규'</span><span class="p">,</span> <span class="s1">'상실'</span><span class="p">]</span>
    <span class="k">for</span> <span class="n">col</span> <span class="ow">in</span> <span class="n">compare_cols</span><span class="p">:</span>
        <span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">5</span><span class="p">))</span>
        <span class="n">sns</span><span class="o">.</span><span class="n">barplot</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="p">[</span><span class="n">company</span><span class="p">,</span> <span class="s1">'업종평균'</span><span class="p">],</span> <span class="n">y</span><span class="o">=</span><span class="n">col</span><span class="p">,</span> <span class="n">data</span><span class="o">=</span><span class="n">df_company</span><span class="p">)</span>
        <span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'</span><span class="si">{}</span><span class="s1"> vs 업종평균'</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">col</span><span class="p">),</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">18</span><span class="p">)</span>
        <span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">compare_and_visualize</span><span class="p">(</span><span class="s1">'패스트캠퍼스'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span> 
</pre></div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>