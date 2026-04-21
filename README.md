# 8051-LED-Control-Assembly
8051 Assembly program for LED pattern control using look-up tables and precise software delay loops (0.25s, 0.5s, 1s).
# 8051 LED Control with Assembly

這是一個基於 **8051 單晶片** 的組合語言專案。透過查表法與軟體延時迴圈，實現了多種規律的 LED 顯示效果。

##  運作邏輯
[cite_start]程式透過 `DPTR` 指向資料表 `LED_TABLE` [cite: 3][cite_start]，並將讀取的代碼輸出至 `P0` 到 `P3` 埠口 [cite: 12, 15, 18, 21]。

### 顯示模式
1. [cite_start]**模式 A**：循環 10 次，每次間隔 0.5 秒 [cite: 1, 4]。
2. [cite_start]**模式 B**：循環 6 次，每次間隔 0.25 秒 [cite: 2, 5]。
3. [cite_start]**模式 C**：循環 8 次，每次間隔 1.0 秒 [cite: 2, 6]。

##  延時演算法
[cite_start]專案中包含了一個精確的延時副程式 `DELAY_025S` [cite: 24]，其計算公式為：
[cite_start]`T = 1 + R5 * [1 + R4 * (1 + R3 * 2 + 2) + 2] + 2` [cite: 24]
[cite_start]透過巢狀迴圈達到約 250,499 微秒的延遲 [cite: 24]。

##  開發工具
- 語言：8051 Assembly (A51)
- [cite_start]檔案：`HW1.a51` [cite: 1]
