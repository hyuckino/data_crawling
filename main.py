from urllib.request import urlopen
from bs4 import BeautifulSoup
import os
from dotenv import load_dotenv
import pymysql
import time
import requests

load_dotenv()

# --- 1. 빈 값/에러를 막아주는 안전망 함수 ---
def safe_float(val):
    if not val:  # 값이 아예 없으면 None 반환
        return None
    # 쉼표, % 기호, 공백 제거
    val = str(val).replace(',', '').replace('%', '').strip()
    # 에프앤가이드 특유의 빈칸 기호들 처리
    if val in ['', '-', 'N/A']:
        return None
    try:
        return float(val)
    except ValueError:
        return None

def safe_int(val):
    if not val:
        return None
    val = str(val).replace(',', '').strip()
    if val in ['', '-', 'N/A']:
        return None
    try:
        return int(val)
    except ValueError:
        return None
# ---------------------------------------------

def stock_crawling(item):
    url = "https://comp.fnguide.com/SVO2/ASP/SVD_main.asp?pGB=1&gicode=A"+item+"&cID=&MenuYn=Y&ReportGB=&NewMenuID=11&stkGb=&strResearchYN="
    resp = urlopen(url)
    raw = resp.read()

    html = raw.decode('utf-8', errors='replace')
    bs_obj = BeautifulSoup(html, "html.parser")

    # 날짜
    date1 = bs_obj.find("span", {"class":"date"})
    date = date1.text.replace('[','').replace(']','').replace('/','-') if date1 else None

    # 기업 정보 & 종목 코드
    corp_name = bs_obj.find("h1", {"id":"giName"}).text
    code = bs_obj.find("div", {"class": "corp_group1"}).find("h2").text

    # 🛡️ 2. 데이터 추출 시 안전망 함수 적용
    stock_price = safe_int(bs_obj.find("span", {"id":"svdMainChartTxt11"}).text)
    fgn_own_ratio = safe_float(bs_obj.find("span", {"id":"svdMainChartTxt12"}).text)
    rel_return = safe_float(bs_obj.find("span", {"id":"svdMainChartTxt13"}).text)

    # 상단 테이블
    up_list = bs_obj.find("div", {"class":"corp_group2"})
    dd = up_list.find_all("dd")

    per = safe_float(dd[1].text)
    per_12m = safe_float(dd[3].text)
    per_ind = safe_float(dd[5].text)
    pbr = safe_float(dd[7].text)
    div_yid = safe_float(dd[9].text)

    # 시세현황 테이블
    table1 = bs_obj.find("div",{"id":"div1"})
    table2 = table1.find_all("td")
    
    volume = safe_int(table2[1].text)
    trans_price = safe_int(table2[3].text)
    mk_cpt_pfr = safe_int(table2[6].text)
    mk_cpt_cm = safe_int(table2[8].text)

    res = [date, corp_name, code, stock_price, fgn_own_ratio, rel_return,
           per, per_12m, per_ind, pbr, div_yid, volume, trans_price, mk_cpt_pfr, mk_cpt_cm]
    
    return res

def db_insert(res):
    conn = None  # DB 연결 초기화
    channel = "#stock_alarm01"
    
    db_pw = os.getenv('DB_PASSWORD')
    slack_token = os.getenv('SLACK_TOKEN')
    channel = "#stock_alarm01"

    try:
        conn = pymysql.connect(host='localhost', user='root', password=db_pw, db='stock', charset='utf8')
        db = conn.cursor()
        

        sql_state = """
            INSERT INTO stock.daily_market(
                dt, item_name, item_code, price, foreign_ownership_ratio, rel_return,
                per, per_12m, per_ind, pbr, dividend_yield, volume, trans_price, market_capital_prefer, market_capital_common
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        
        # 튜플 형태로 데이터를 통째로 넘김
        db.execute(sql_state, tuple(res))
        conn.commit()
        
        text = f"{res[0]}일 {res[1]} 주식정보 수집완료!"
        requests.post("https://slack.com/api/chat.postMessage",
                      headers={"Authorization": f"Bearer {slack_token}"},
                      data={"channel": channel, "text": text})

    except Exception as e:
        print(f"DB 저장 중 에러: {e}")
        text = "Check your stock crawler. (DB Insert Error)"
        requests.post("https://slack.com/api/chat.postMessage",
                      headers={"Authorization": f"Bearer {slack_token}"},
                      data={"channel": channel, "text": text})
        
    finally:
        # DB 연결이 생성된 경우에만 닫도록 안전하게 처리
        if conn is not None:
            conn.close()

if __name__ == '__main__':
    item_list = ['005930','088350','259960']

    for item in item_list:
        try:
            res = stock_crawling(item) 
            db_insert(res)
            print(f"{item} 수집 완료")
        except Exception as e:
            print(f"{item} 크롤링 중 에러 발생: {e}")
            
        time.sleep(3)