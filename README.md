# WalletPet / Wallet Meow｜遊戲化記帳系統

本專案為 **WalletMeow Studio 共同開發專題**，是一套結合「理財記帳」與「寵物互動養成」的遊戲化記帳系統。  
專案參與人員為[@WalletMeowStudio](https://github.com/WalletMeowStudio)之六人團隊。

---

## 專案內容

```text
walletpet/
├── walletpet.jar      # Spring Boot 可執行 JAR，內含 Web 前端頁面與後端 API
├── walletpet.sql      # MySQL schema / demo data
└── README.md
```

---

## 系統簡介

WalletPet / Wallet Meow 是一套結合理財記帳與寵物互動的系統。使用者可管理收入、支出、轉帳、帳戶、分類、預算與存錢目標；系統會依照使用者的登入、記帳與餵食行為，更新寵物的心情值 `mood` 與食物量 `cancan`，並透過事件紀錄、登入 streak、每日記帳獎勵與寵物動畫狀態，提升持續記帳的動機。

本系統除一般使用者功能外，也提供管理員後台，可查看使用者總覽、單一使用者分析、群體分析，並支援管理員測試與調整寵物心情值，方便展示系統邏輯與資料變化。

---

## 專案亮點

### 1. 遊戲化記帳設計

系統不是單純的收支紀錄工具，而是將記帳行為與寵物養成結合。使用者完成每日記帳後可獲得 `cancan` 獎勵，登入 streak 也會觸發額外回饋，使記帳行為轉化為可視化、可互動的遊戲回饋。

### 2. 寵物 mood / cancan 狀態機制

寵物具有心情值 `mood` 與食物量 `cancan`。使用者可以透過記帳獲得食物量，再透過餵食提升心情值。不同心情區間會對應不同寵物狀態與互動畫面，讓財務管理具有養成感。

### 3. 完整理財模組

系統涵蓋個人記帳常見核心功能，包含：

- 帳戶管理
- 收入 / 支出記帳
- 分類管理
- 轉帳紀錄
- 預算管理
- 存錢目標
- 收支分析圖表
- 每日登入與每日記帳獎勵

### 4. 前後端整合與 REST API 串接

前端頁面透過 REST API 與後端串接，後端負責 JWT 驗證、商業邏輯、資料庫操作與統計資料計算。系統功能涵蓋一般使用者端與管理員端，適合展示完整 Web 專題的前後端整合能力。

### 5. 管理員後台分析功能

管理員可查看使用者月度收支與記帳摘要、單一使用者收支分析、群體統計資料、熱門支出分類與低活躍使用者，並可查詢指定使用者的寵物資料與調整 mood 心情值。

### 6. 可部署展示的 JAR 版本

前端頁面已整合進 Spring Boot JAR 中，啟動 `walletpet.jar` 後即可透過瀏覽器操作系統，不需要另外啟動前端伺服器。

---

## 技術架構

| 類別 | 技術 |
|---|---|
| 後端 | Java、Spring Boot、Spring Data JPA、REST API |
| 前端 | HTML、CSS、JavaScript、jQuery、Bootstrap |
| 資料庫 | MySQL |
| 認證 | JWT Token |
| 文件 | Swagger UI / OpenAPI |
| 打包 | Spring Boot Executable JAR |
| 互動動畫 | Rive 動畫 / 寵物狀態互動 |

---

## 主要功能

### 使用者功能

- 註冊與登入
- 查看主畫面、本月收入、本月支出與近期交易
- 管理帳戶與查看資產摘要
- 新增、查詢、修改收入 / 支出交易
- 查詢月曆式記帳紀錄與每日明細
- 管理收入 / 支出分類
- 建立與查詢轉帳紀錄
- 建立存錢目標與存入目標金額
- 建立預算並查看預算進度
- 查看收支分析、支出分類圓餅圖與現金流趨勢
- 查看寵物狀態、餵食寵物與查詢寵物事件紀錄
- 觸發每日登入 streak 與每日記帳獎勵

### 管理員功能

- 管理員登入
- 查看使用者總覽
- 查看單一使用者分析
- 查看群體分析
- 查詢指定使用者寵物
- 調整寵物 mood 心情值
- 檢視使用者活躍度與收支統計

---

## 執行方式

### 1. 確認 Java 環境

建議使用 JDK 執行，先確認 Java 是否可用：

```bash
java -version
```

若 Windows 環境有多個 Java 版本，請確認 `where java` 第一個路徑指向正確的 JDK。

```bash
where java
```

---

### 2. 建立 MySQL 資料庫

請先啟動 MySQL，並匯入 `walletpet.sql`。

可先建立資料庫：

```sql
CREATE DATABASE walletpet DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

接著匯入 SQL 檔：

```bash
mysql -u root -p walletpet < walletpet.sql
```

> 若 SQL 檔內已包含 `CREATE DATABASE` 或 `USE walletpet;`，請依實際 SQL 內容調整匯入方式。

---

### 3. 啟動系統

在 `walletpet.jar` 所在資料夾執行：

```bash
java -jar walletpet.jar
```

若啟動成功，終端機會看到 Spring Boot / Tomcat 啟動訊息，例如：

```text
Tomcat started on port 8080
Started ...Application
```

---

## 系統入口

啟動 JAR 後，請使用以下網址進入系統：

```text
http://localhost:8080/walletpet/login.html
```

---

## Swagger UI

若需要查看或測試後端 API，可使用 Swagger UI：

```text
http://localhost:8080/walletpet/swagger-ui.html
```

---

## 測試帳號

可使用下列測試帳號登入系統：

| 角色 / 用途 | 帳號 | 密碼 | 說明 |
|---|---|---|---|
| 管理員 | admin | 1234 | 可進入管理員後台，查看使用者總覽、分析資料與寵物測試功能。 |
| 一般使用者 | demo | 123456 | 可測試一般記帳、帳戶、分類、轉帳、預算、目標與寵物互動功能。 |
| 未登入測試使用者 | absent | 123456 | 可用於展示未登入 / 低活躍或登入 streak 相關情境。 |

---

## 自行註冊試用

除上述測試帳號外，也可以在登入頁點選註冊，自行新增一般使用者帳號試用系統。  
註冊後系統會依照後端使用者建立流程初始化基本資料，例如預設分類、初始帳戶與寵物資料，讓新使用者可以直接進行記帳與寵物互動測試。

---

## 建議展示流程

1. 使用 `demo / 123456` 登入一般使用者端。
2. 查看主畫面的本月收支、近期交易與寵物狀態。
3. 新增一筆收入或支出，觀察交易紀錄與每日記帳獎勵。
4. 進入我的寵物頁，查看 `mood`、`cancan` 與事件紀錄。
5. 測試餵食寵物，觀察心情值變化。
6. 測試帳戶、分類、轉帳、預算與存錢目標功能。
7. 切換至收支分析頁，查看圓餅圖與趨勢圖。
8. 使用 `admin / 1234` 登入管理員端。
9. 查看使用者總覽、單一使用者分析、群體分析與寵物 mood 測試功能。
10. 開啟 Swagger UI，確認後端 API 文件與可測試端點。

---

## 展示重點

此專案適合展示以下能力：

- Spring Boot JAR 部署
- REST API 前後端整合
- JWT 登入驗證與角色權限控管
- MySQL 資料表設計與 JPA 操作
- 個人記帳、轉帳、預算、目標與分析圖表整合
- 遊戲化機制設計：每日記帳獎勵、登入 streak、寵物 mood / cancan
- 管理員後台統計與使用者分析
- Swagger UI API 文件整合
- 共同專題中的模組協作、功能整合與展示資料設計

---

## 備註

- 本專案為共同專題成果，參與人員請參考隨附 PDF 簡報。
- 若啟動後無法連線，請先確認 MySQL 是否啟動、資料庫名稱與帳密設定是否符合 JAR 內設定。
- 若 Swagger UI 無法開啟，請確認 JAR 是否成功啟動，以及網址是否包含 `/walletpet` context path。
