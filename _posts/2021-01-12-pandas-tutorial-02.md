---
layout: page
title: "에피소드#02 - Pandas(판다스)의 파일 입출력 - Excel, CSV"
description: "에피소드#02 - Pandas(판다스)의 파일 입출력 - Excel, CSV에 대해 알아보겠습니다."
headline: "에피소드#02 - Pandas(판다스)의 파일 입출력 - Excel, CSV에 대해 알아보겠습니다."
categories: pandas
tags: [python, pandas, dataframe, series, pandas tutorial, excel, csv, 판다스, 판다스 자료구조, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-01-12
---

이번 에피소드에서는 Pandas의 **파일 입출력**에 대하여 알아보겠습니다. 그리고, 데이터 분석에서 DB를 제외한 가장 많이 사용되는 파일 형식인 엑셀(Excel)과 CSV (Comma Separated Value)을 로드하고 데이터프레임(DataFrame)을 엑셀(Excel)이나 CSV형식으로 저장하는 방법에 대하여 공유하고자 합니다.

<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="모듈-import">모듈 import</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">IPython.display</span> <span class="kn">import</span> <span class="n">Image</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">pandas</span> <span class="k">as</span> <span class="nn">pd</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="Excel">Excel</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><a href="https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_excel.html">도큐먼트</a></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="Excel---불러오기">Excel - 불러오기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Excel 데이터를 바로 읽어들일 수 있으며, <code>sheet_name</code>을 지정하면 해당 sheet를 가져옵니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_excel</span><span class="p">(</span><span class="s1">'seoul_transportation.xlsx'</span><span class="p">,</span> <span class="n">sheet_name</span><span class="o">=</span><span class="s1">'철도'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>대중교통구분</th>
<th>노선명</th>
<th>년월</th>
<th>승차총승객수</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>지하철</td>
<td>1호선</td>
<td>201711</td>
<td>8633618</td>
</tr>
<tr>
<th>1</th>
<td>지하철</td>
<td>1호선</td>
<td>201712</td>
<td>8737235</td>
</tr>
<tr>
<th>2</th>
<td>지하철</td>
<td>1호선</td>
<td>201801</td>
<td>8145989</td>
</tr>
<tr>
<th>3</th>
<td>지하철</td>
<td>1호선</td>
<td>201802</td>
<td>7273309</td>
</tr>
<tr>
<th>4</th>
<td>지하철</td>
<td>1호선</td>
<td>201803</td>
<td>8692551</td>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_excel</span><span class="p">(</span><span class="s1">'seoul_transportation.xlsx'</span><span class="p">,</span> <span class="n">sheet_name</span><span class="o">=</span><span class="s1">'버스'</span><span class="p">)</span>
<span class="n">excel</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>대중교통구분</th>
<th>년월</th>
<th>승차총승객수</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>버스</td>
<td>201711</td>
<td>163443126</td>
</tr>
<tr>
<th>1</th>
<td>버스</td>
<td>201712</td>
<td>162521011</td>
</tr>
<tr>
<th>2</th>
<td>버스</td>
<td>201801</td>
<td>153335185</td>
</tr>
<tr>
<th>3</th>
<td>버스</td>
<td>201802</td>
<td>134768582</td>
</tr>
<tr>
<th>4</th>
<td>버스</td>
<td>201803</td>
<td>166177855</td>
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
<p><code>sheet_name</code>을 None으로 지정하면, 모든 sheet를 가지고 옵니다.</p>
<p>가지고 올 때는 OrderedDict로 가져오며, <code>keys()</code>로 <strong>시트명을 조회</strong>할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_excel</span><span class="p">(</span><span class="s1">'seoul_transportation.xlsx'</span><span class="p">,</span> <span class="n">sheet_name</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>
<span class="n">excel</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>OrderedDict([('철도',     대중교통구분    노선명      년월   승차총승객수
              0      지하철    1호선  201711  8633618
              1      지하철    1호선  201712  8737235
              2      지하철    1호선  201801  8145989
              3      지하철    1호선  201802  7273309
              4      지하철    1호선  201803  8692551
              ..     ...    ...     ...      ...
              596    지하철  우이신설선  201901  1263643
              597    지하철  우이신설선  201902  1102109
              598    지하철  우이신설선  201903  1402393
              599    지하철  우이신설선  201904  1403115
              600    지하철  우이신설선  201905  1469681
              
              [601 rows x 4 columns]), ('버스',    대중교통구분      년월     승차총승객수
              0      버스  201711  163443126
              1      버스  201712  162521011
              2      버스  201801  153335185
              3      버스  201802  134768582
              4      버스  201803  166177855
              5      버스  201804  160452595
              6      버스  201805  164390595
              7      버스  201806  156999747
              8      버스  201807  163736112
              9      버스  201808  160240197
              10     버스  201809  151311657
              11     버스  201810  165820934
              12     버스  201811  163017758
              13     버스  201812  158049446
              14     버스  201901  153037549
              15     버스  201902  131621925
              16     버스  201903  161694445
              17     버스  201904  161900273
              18     버스  201905  166587933)])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 시트 조회</span>
<span class="n">excel</span><span class="o">.</span><span class="n">keys</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>odict_keys(['철도', '버스'])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span><span class="p">[</span><span class="s1">'철도'</span><span class="p">]</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>대중교통구분</th>
<th>노선명</th>
<th>년월</th>
<th>승차총승객수</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>지하철</td>
<td>1호선</td>
<td>201711</td>
<td>8633618</td>
</tr>
<tr>
<th>1</th>
<td>지하철</td>
<td>1호선</td>
<td>201712</td>
<td>8737235</td>
</tr>
<tr>
<th>2</th>
<td>지하철</td>
<td>1호선</td>
<td>201801</td>
<td>8145989</td>
</tr>
<tr>
<th>3</th>
<td>지하철</td>
<td>1호선</td>
<td>201802</td>
<td>7273309</td>
</tr>
<tr>
<th>4</th>
<td>지하철</td>
<td>1호선</td>
<td>201803</td>
<td>8692551</td>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span><span class="p">[</span><span class="s1">'버스'</span><span class="p">]</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>대중교통구분</th>
<th>년월</th>
<th>승차총승객수</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>버스</td>
<td>201711</td>
<td>163443126</td>
</tr>
<tr>
<th>1</th>
<td>버스</td>
<td>201712</td>
<td>162521011</td>
</tr>
<tr>
<th>2</th>
<td>버스</td>
<td>201801</td>
<td>153335185</td>
</tr>
<tr>
<th>3</th>
<td>버스</td>
<td>201802</td>
<td>134768582</td>
</tr>
<tr>
<th>4</th>
<td>버스</td>
<td>201803</td>
<td>166177855</td>
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
<h3 id="Excel---저장하기">Excel - 저장하기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>DataFrame을 Excel로 저장할 수 있으며, Excel로 저장시 <strong>파일명</strong>을 지정합니다.</p>
<ul>
<li><code>index=False</code> 옵션은 가급적 꼭 지정하는 옵션입니다. 지정을 안하면 <strong>index가 별도의 컬럼으로 저장</strong>되게 됩니다.</li>
<li><code>sheet_name</code>을 지정하여, 저장할 시트의 이름을 변경할 수 있습니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span><span class="o">.</span><span class="n">to_excel</span><span class="p">(</span><span class="s1">'sample.xlsx'</span><span class="p">,</span> <span class="n">index</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span><span class="o">.</span><span class="n">to_excel</span><span class="p">(</span><span class="s1">'sample1.xlsx'</span><span class="p">,</span> <span class="n">index</span><span class="o">=</span><span class="kc">False</span><span class="p">,</span> <span class="n">sheet_name</span><span class="o">=</span><span class="s1">'샘플'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="Excel---여러개의-시트에-저장">Excel - 여러개의 시트에 저장</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>여래 개의 시트에 저장하기 위해서는 <strong>ExcelWriter를 사용</strong>해야 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">writer</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">ExcelWriter</span><span class="p">(</span><span class="s1">'sample2.xlsx'</span><span class="p">)</span>
<span class="n">excel</span><span class="o">.</span><span class="n">to_excel</span><span class="p">(</span><span class="n">writer</span><span class="p">,</span> <span class="n">index</span><span class="o">=</span><span class="kc">False</span><span class="p">,</span> <span class="n">sheet_name</span><span class="o">=</span><span class="s1">'샘플1'</span><span class="p">)</span>
<span class="n">excel</span><span class="o">.</span><span class="n">to_excel</span><span class="p">(</span><span class="n">writer</span><span class="p">,</span> <span class="n">index</span><span class="o">=</span><span class="kc">False</span><span class="p">,</span> <span class="n">sheet_name</span><span class="o">=</span><span class="s1">'샘플2'</span><span class="p">)</span>
<span class="n">excel</span><span class="o">.</span><span class="n">to_excel</span><span class="p">(</span><span class="n">writer</span><span class="p">,</span> <span class="n">index</span><span class="o">=</span><span class="kc">False</span><span class="p">,</span> <span class="n">sheet_name</span><span class="o">=</span><span class="s1">'샘플3'</span><span class="p">)</span>
<span class="n">writer</span><span class="o">.</span><span class="n">close</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="CSV-(Comma-Separated-Values)">CSV (Comma Separated Values)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>한 줄이 한 개의 행에 해당하며, 열 사이에는<strong> 쉼표(,)를 넣어 구분</strong>합니다.</li>
<li>Excel보다는 훨씬 가볍고 <strong>차지하는 용량이 적기 때문에 대부분의 파일데이터는 csv 형태</strong>로 제공됩니다.</li>
</ul>
<p>(참고) 쉼표를 찍어 놓은 금액 데이터(100,000)를 CSV에 직접 집어넣으면 나중에 해석할 때 서로 다른 열로 취급되므로 문제가 될 수 있습니다. 해결책으로 쉼표 대신 탭 문자(\t)를 구분자로 사용하는 것이다. 이러한 경우 <strong>Tab Separated Values(TSV)</strong>라고 부른다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="CSV---불러오기">CSV - 불러오기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_csv</span><span class="p">(</span><span class="s1">'seoul_population.csv'</span><span class="p">)</span>
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
<th>자치구</th>
<th>세대</th>
<th>계</th>
<th>남자</th>
<th>여자</th>
<th>계.1</th>
<th>남자.1</th>
<th>여자.1</th>
<th>계.2</th>
<th>남자.2</th>
<th>여자.2</th>
<th>세대당인구</th>
<th>65세이상고령자</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>합계</td>
<td>4,202,888</td>
<td>10,197,604</td>
<td>5,000,005</td>
<td>5,197,599</td>
<td>9,926,968</td>
<td>4,871,560</td>
<td>5,055,408</td>
<td>270,636</td>
<td>128,445</td>
<td>142,191</td>
<td>2.36</td>
<td>1,321,458</td>
</tr>
<tr>
<th>1</th>
<td>종로구</td>
<td>72,654</td>
<td>162,820</td>
<td>79,675</td>
<td>83,145</td>
<td>153,589</td>
<td>75,611</td>
<td>77,978</td>
<td>9,231</td>
<td>4,064</td>
<td>5,167</td>
<td>2.11</td>
<td>25,425</td>
</tr>
<tr>
<th>2</th>
<td>중구</td>
<td>59,481</td>
<td>133,240</td>
<td>65,790</td>
<td>67,450</td>
<td>124,312</td>
<td>61,656</td>
<td>62,656</td>
<td>8,928</td>
<td>4,134</td>
<td>4,794</td>
<td>2.09</td>
<td>20,764</td>
</tr>
<tr>
<th>3</th>
<td>용산구</td>
<td>106,544</td>
<td>244,203</td>
<td>119,132</td>
<td>125,071</td>
<td>229,456</td>
<td>111,167</td>
<td>118,289</td>
<td>14,747</td>
<td>7,965</td>
<td>6,782</td>
<td>2.15</td>
<td>36,231</td>
</tr>
<tr>
<th>4</th>
<td>성동구</td>
<td>130,868</td>
<td>311,244</td>
<td>153,768</td>
<td>157,476</td>
<td>303,380</td>
<td>150,076</td>
<td>153,304</td>
<td>7,864</td>
<td>3,692</td>
<td>4,172</td>
<td>2.32</td>
<td>39,997</td>
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
<p>때때로 한글데이터를 불러올 때 다른 인코딩을 사용해야하는 경우도 있습니다.그럴 땐 <code>encoding</code> 옵션을 지정해주면 됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_csv</span><span class="p">(</span><span class="s1">'seoul_population.csv'</span><span class="p">,</span> <span class="n">encoding</span><span class="o">=</span><span class="s1">'utf8'</span><span class="p">)</span>
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
<th>자치구</th>
<th>세대</th>
<th>계</th>
<th>남자</th>
<th>여자</th>
<th>계.1</th>
<th>남자.1</th>
<th>여자.1</th>
<th>계.2</th>
<th>남자.2</th>
<th>여자.2</th>
<th>세대당인구</th>
<th>65세이상고령자</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>합계</td>
<td>4,202,888</td>
<td>10,197,604</td>
<td>5,000,005</td>
<td>5,197,599</td>
<td>9,926,968</td>
<td>4,871,560</td>
<td>5,055,408</td>
<td>270,636</td>
<td>128,445</td>
<td>142,191</td>
<td>2.36</td>
<td>1,321,458</td>
</tr>
<tr>
<th>1</th>
<td>종로구</td>
<td>72,654</td>
<td>162,820</td>
<td>79,675</td>
<td>83,145</td>
<td>153,589</td>
<td>75,611</td>
<td>77,978</td>
<td>9,231</td>
<td>4,064</td>
<td>5,167</td>
<td>2.11</td>
<td>25,425</td>
</tr>
<tr>
<th>2</th>
<td>중구</td>
<td>59,481</td>
<td>133,240</td>
<td>65,790</td>
<td>67,450</td>
<td>124,312</td>
<td>61,656</td>
<td>62,656</td>
<td>8,928</td>
<td>4,134</td>
<td>4,794</td>
<td>2.09</td>
<td>20,764</td>
</tr>
<tr>
<th>3</th>
<td>용산구</td>
<td>106,544</td>
<td>244,203</td>
<td>119,132</td>
<td>125,071</td>
<td>229,456</td>
<td>111,167</td>
<td>118,289</td>
<td>14,747</td>
<td>7,965</td>
<td>6,782</td>
<td>2.15</td>
<td>36,231</td>
</tr>
<tr>
<th>4</th>
<td>성동구</td>
<td>130,868</td>
<td>311,244</td>
<td>153,768</td>
<td>157,476</td>
<td>303,380</td>
<td>150,076</td>
<td>153,304</td>
<td>7,864</td>
<td>3,692</td>
<td>4,172</td>
<td>2.32</td>
<td>39,997</td>
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
<h3 id="CSV---큰-파일-데이터-끊어서-불러오기">CSV - 큰 파일 데이터 끊어서 불러오기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>데이터의 크기가 매우 큰 경우 memory에 한 번에 로드할 수 없습니다.</p>
<p><code>chunksize</code>를 지정하고 <code>chunksize</code>만큼 끊어서 불어와서 처리하게 되면 용량이 매우 큰 데이터도 처리할 수 있습니다.</p>
<p>예시) <code>chunksize=10</code>: 10개의 데이터를 로드합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_csv</span><span class="p">(</span><span class="s1">'seoul_population.csv'</span><span class="p">,</span> <span class="n">chunksize</span><span class="o">=</span><span class="mi">10</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">df</span><span class="p">:</span>
    <span class="n">display</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_html rendered_html output_subarea">
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
<th>자치구</th>
<th>세대</th>
<th>계</th>
<th>남자</th>
<th>여자</th>
<th>계.1</th>
<th>남자.1</th>
<th>여자.1</th>
<th>계.2</th>
<th>남자.2</th>
<th>여자.2</th>
<th>세대당인구</th>
<th>65세이상고령자</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>합계</td>
<td>4,202,888</td>
<td>10,197,604</td>
<td>5,000,005</td>
<td>5,197,599</td>
<td>9,926,968</td>
<td>4,871,560</td>
<td>5,055,408</td>
<td>270,636</td>
<td>128,445</td>
<td>142,191</td>
<td>2.36</td>
<td>1,321,458</td>
</tr>
<tr>
<th>1</th>
<td>종로구</td>
<td>72,654</td>
<td>162,820</td>
<td>79,675</td>
<td>83,145</td>
<td>153,589</td>
<td>75,611</td>
<td>77,978</td>
<td>9,231</td>
<td>4,064</td>
<td>5,167</td>
<td>2.11</td>
<td>25,425</td>
</tr>
<tr>
<th>2</th>
<td>중구</td>
<td>59,481</td>
<td>133,240</td>
<td>65,790</td>
<td>67,450</td>
<td>124,312</td>
<td>61,656</td>
<td>62,656</td>
<td>8,928</td>
<td>4,134</td>
<td>4,794</td>
<td>2.09</td>
<td>20,764</td>
</tr>
<tr>
<th>3</th>
<td>용산구</td>
<td>106,544</td>
<td>244,203</td>
<td>119,132</td>
<td>125,071</td>
<td>229,456</td>
<td>111,167</td>
<td>118,289</td>
<td>14,747</td>
<td>7,965</td>
<td>6,782</td>
<td>2.15</td>
<td>36,231</td>
</tr>
<tr>
<th>4</th>
<td>성동구</td>
<td>130,868</td>
<td>311,244</td>
<td>153,768</td>
<td>157,476</td>
<td>303,380</td>
<td>150,076</td>
<td>153,304</td>
<td>7,864</td>
<td>3,692</td>
<td>4,172</td>
<td>2.32</td>
<td>39,997</td>
</tr>
<tr>
<th>5</th>
<td>광진구</td>
<td>158,960</td>
<td>372164</td>
<td>180992</td>
<td>191172</td>
<td>357211</td>
<td>174599</td>
<td>182612</td>
<td>14953</td>
<td>6393</td>
<td>8560</td>
<td>2.25</td>
<td>42214</td>
</tr>
<tr>
<th>6</th>
<td>동대문구</td>
<td>159839</td>
<td>369496</td>
<td>182932</td>
<td>186564</td>
<td>354079</td>
<td>177021</td>
<td>177058</td>
<td>15417</td>
<td>5911</td>
<td>9506</td>
<td>2.22</td>
<td>54173</td>
</tr>
<tr>
<th>7</th>
<td>중랑구</td>
<td>177548</td>
<td>414503</td>
<td>206102</td>
<td>208401</td>
<td>409882</td>
<td>204265</td>
<td>205617</td>
<td>4621</td>
<td>1837</td>
<td>2784</td>
<td>2.31</td>
<td>56774</td>
</tr>
<tr>
<th>8</th>
<td>성북구</td>
<td>188512</td>
<td>461260</td>
<td>224076</td>
<td>237184</td>
<td>449773</td>
<td>219545</td>
<td>230228</td>
<td>11487</td>
<td>4531</td>
<td>6956</td>
<td>2.39</td>
<td>64692</td>
</tr>
<tr>
<th>9</th>
<td>강북구</td>
<td>141554</td>
<td>330192</td>
<td>161686</td>
<td>168506</td>
<td>326686</td>
<td>160353</td>
<td>166333</td>
<td>3506</td>
<td>1333</td>
<td>2173</td>
<td>2.31</td>
<td>54813</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="output_area">
<div class="prompt"></div>
<div class="output_html rendered_html output_subarea">
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
<th>자치구</th>
<th>세대</th>
<th>계</th>
<th>남자</th>
<th>여자</th>
<th>계.1</th>
<th>남자.1</th>
<th>여자.1</th>
<th>계.2</th>
<th>남자.2</th>
<th>여자.2</th>
<th>세대당인구</th>
<th>65세이상고령자</th>
</tr>
</thead>
<tbody>
<tr>
<th>10</th>
<td>도봉구</td>
<td>136613</td>
<td>348646</td>
<td>171026</td>
<td>177620</td>
<td>346629</td>
<td>170289</td>
<td>176340</td>
<td>2017</td>
<td>737</td>
<td>1280</td>
<td>2.54</td>
<td>51312</td>
</tr>
<tr>
<th>11</th>
<td>노원구</td>
<td>219957</td>
<td>569384</td>
<td>276823</td>
<td>292561</td>
<td>565565</td>
<td>275211</td>
<td>290354</td>
<td>3819</td>
<td>1612</td>
<td>2207</td>
<td>2.57</td>
<td>71941</td>
</tr>
<tr>
<th>12</th>
<td>은평구</td>
<td>201869</td>
<td>494388</td>
<td>240220</td>
<td>254168</td>
<td>489943</td>
<td>238337</td>
<td>251606</td>
<td>4445</td>
<td>1883</td>
<td>2562</td>
<td>2.43</td>
<td>72334</td>
</tr>
<tr>
<th>13</th>
<td>서대문구</td>
<td>137207</td>
<td>327163</td>
<td>156765</td>
<td>170398</td>
<td>314982</td>
<td>152613</td>
<td>162369</td>
<td>12181</td>
<td>4152</td>
<td>8029</td>
<td>2.30</td>
<td>48161</td>
</tr>
<tr>
<th>14</th>
<td>마포구</td>
<td>169404</td>
<td>389649</td>
<td>185889</td>
<td>203760</td>
<td>378566</td>
<td>181346</td>
<td>197220</td>
<td>11083</td>
<td>4543</td>
<td>6540</td>
<td>2.23</td>
<td>48765</td>
</tr>
<tr>
<th>15</th>
<td>양천구</td>
<td>176921</td>
<td>479978</td>
<td>237117</td>
<td>242861</td>
<td>475949</td>
<td>235278</td>
<td>240671</td>
<td>4029</td>
<td>1839</td>
<td>2190</td>
<td>2.69</td>
<td>52975</td>
</tr>
<tr>
<th>16</th>
<td>강서구</td>
<td>247696</td>
<td>603772</td>
<td>294433</td>
<td>309339</td>
<td>597248</td>
<td>291249</td>
<td>305999</td>
<td>6524</td>
<td>3184</td>
<td>3340</td>
<td>2.41</td>
<td>72548</td>
</tr>
<tr>
<th>17</th>
<td>구로구</td>
<td>172272</td>
<td>447874</td>
<td>224436</td>
<td>223438</td>
<td>416487</td>
<td>207114</td>
<td>209373</td>
<td>31387</td>
<td>17322</td>
<td>14065</td>
<td>2.42</td>
<td>56833</td>
</tr>
<tr>
<th>18</th>
<td>금천구</td>
<td>105146</td>
<td>255082</td>
<td>130558</td>
<td>124524</td>
<td>236353</td>
<td>120334</td>
<td>116019</td>
<td>18729</td>
<td>10224</td>
<td>8505</td>
<td>2.25</td>
<td>32970</td>
</tr>
<tr>
<th>19</th>
<td>영등포구</td>
<td>165462</td>
<td>402985</td>
<td>202573</td>
<td>200412</td>
<td>368072</td>
<td>183705</td>
<td>184367</td>
<td>34913</td>
<td>18868</td>
<td>16045</td>
<td>2.22</td>
<td>52413</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="output_area">
<div class="prompt"></div>
<div class="output_html rendered_html output_subarea">
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
<th>자치구</th>
<th>세대</th>
<th>계</th>
<th>남자</th>
<th>여자</th>
<th>계.1</th>
<th>남자.1</th>
<th>여자.1</th>
<th>계.2</th>
<th>남자.2</th>
<th>여자.2</th>
<th>세대당인구</th>
<th>65세이상고령자</th>
</tr>
</thead>
<tbody>
<tr>
<th>20</th>
<td>동작구</td>
<td>173033</td>
<td>412520</td>
<td>201217</td>
<td>211303</td>
<td>400456</td>
<td>195775</td>
<td>204681</td>
<td>12064</td>
<td>5442</td>
<td>6622</td>
<td>2.31</td>
<td>56013</td>
</tr>
<tr>
<th>21</th>
<td>관악구</td>
<td>253826</td>
<td>525515</td>
<td>264763</td>
<td>260752</td>
<td>507203</td>
<td>256090</td>
<td>251113</td>
<td>18312</td>
<td>8673</td>
<td>9639</td>
<td>2.00</td>
<td>68082</td>
</tr>
<tr>
<th>22</th>
<td>서초구</td>
<td>173856</td>
<td>450310</td>
<td>216264</td>
<td>234046</td>
<td>445994</td>
<td>214036</td>
<td>231958</td>
<td>4316</td>
<td>2228</td>
<td>2088</td>
<td>2.57</td>
<td>51733</td>
</tr>
<tr>
<th>23</th>
<td>강남구</td>
<td>234107</td>
<td>570500</td>
<td>273301</td>
<td>297199</td>
<td>565550</td>
<td>270726</td>
<td>294824</td>
<td>4950</td>
<td>2575</td>
<td>2375</td>
<td>2.42</td>
<td>63167</td>
</tr>
<tr>
<th>24</th>
<td>송파구</td>
<td>259883</td>
<td>667483</td>
<td>325040</td>
<td>342443</td>
<td>660584</td>
<td>321676</td>
<td>338908</td>
<td>6899</td>
<td>3364</td>
<td>3535</td>
<td>2.54</td>
<td>72506</td>
</tr>
<tr>
<th>25</th>
<td>강동구</td>
<td>179676</td>
<td>453233</td>
<td>225427</td>
<td>227806</td>
<td>449019</td>
<td>223488</td>
<td>225531</td>
<td>4214</td>
<td>1939</td>
<td>2275</td>
<td>2.50</td>
<td>54622</td>
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
<h3 id="CSV---저장하기">CSV - 저장하기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>저장하는 방법은 excel과 유사합니다. 다만, csv파일 형식에는 <code>sheet_name</code> 옵션은 없습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_csv</span><span class="p">(</span><span class="s1">'seoul_population.csv'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">to_csv</span><span class="p">(</span><span class="s1">'sample.csv'</span><span class="p">,</span> <span class="n">index</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>읽어들인 <strong>Excel 파일도 Csv로 저장</strong>할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_excel</span><span class="p">(</span><span class="s1">'seoul_transportation.xlsx'</span><span class="p">,</span> <span class="n">sheet_name</span><span class="o">=</span><span class="s1">'버스'</span><span class="p">)</span>
<span class="n">excel</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>대중교통구분</th>
<th>년월</th>
<th>승차총승객수</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>버스</td>
<td>201711</td>
<td>163443126</td>
</tr>
<tr>
<th>1</th>
<td>버스</td>
<td>201712</td>
<td>162521011</td>
</tr>
<tr>
<th>2</th>
<td>버스</td>
<td>201801</td>
<td>153335185</td>
</tr>
<tr>
<th>3</th>
<td>버스</td>
<td>201802</td>
<td>134768582</td>
</tr>
<tr>
<th>4</th>
<td>버스</td>
<td>201803</td>
<td>166177855</td>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">excel</span><span class="o">.</span><span class="n">to_csv</span><span class="p">(</span><span class="s1">'sample1.csv'</span><span class="p">,</span> <span class="n">index</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>