## 组装

### CPU
### 内存

#### 布局


|address | memory|R/W|function|
|-|-|-|-|
|0-2047| RAM|R/W|R0--R15, static, stack, heap|
| 8192 | but|R/W|0 = button pressed, 1 = button released|
| 8193 | led|R/W|0 = led off, 1 = led on|
