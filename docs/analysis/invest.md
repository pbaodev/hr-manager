# INVEST review: Must stories

- **Status:** Draft
- **Updated:** 2026-10-31
- **Reviewed:** [YYYY-MM-DD: chủ dự án đọc lại kết quả chấm]
- **Related:** [stories](stories.md) · [requirements](requirements.md) · [domain](domain.md)

> Kết quả chấm 85 story `Must` của v1.0 trong [stories](stories.md#summary) theo sáu tiêu chí INVEST. Story `Should` và
> `Could` được chấm khi được chọn vào kế hoạch. Agent chấm dựa trên câu story và acceptance criteria; chủ dự án đọc lại
> trước khi chuyển `Accepted`. Story `Fail` được ghi lý do, cách sửa đề xuất và Issue xử lý.

## Rubric

| Criterion | Pass khi | Fail khi |
|---|---|---|
| **I**ndependent | Làm và kiểm được trong milestone của story, chỉ cần story `Must` của cùng milestone hoặc milestone trước. Cần dữ liệu do story làm trước tạo ra vẫn tính là Pass | Có acceptance criterion cần story của milestone sau, hoặc cần story `Should`, `Could` |
| **N**egotiable | Story nói người dùng cần gì, không áp đặt cách làm như màn hình, công nghệ hay thuật toán | Story hoặc AC mô tả cách cài đặt |
| **V**aluable | Có vai trò rõ và vế "để ..." nói lợi ích cho vai trò đó | Không thấy ai được lợi, hoặc chỉ là việc kỹ thuật |
| **E**stimable | Luật liên quan đã có mã `BR-xxx`, edge case đã có mã `EC-xxx`; không còn câu hỏi mở hay spike chưa làm chặn story | Còn chỗ mơ hồ làm không ước lượng được |
| **S**mall | Agent ước lượng làm xong backend, frontend và test trong một PR, khoảng 3 ngày công trở xuống | Có từ hai phần việc độc lập trở lên, nên tách |
| **T**estable | Mỗi AC viết dạng Given, When, Then với kết quả kiểm được. AC về nội dung do AI viết được kiểm bằng eval | Có AC không kiểm được, hoặc kết quả không đo được |

Với story AI, tiêu chí S không tính phần chung của M6: module gọi model, lưu AiOutput, kiểm đầu ra và chế độ tắt AI.
Phần này là Task kỹ thuật của Feature M6 khi lập kế hoạch.

## Summary

| Criterion | Pass | Fail |
|---|---|---|
| I | 85 | 0 |
| N | 85 | 0 |
| V | 85 | 0 |
| E | 82 | 3: US-039 (#47), US-082 (#48), US-107 (#49) |
| S | 74 | 11: US-006, US-023, US-029, US-040, US-051, US-084, US-085, US-090, US-091, US-107, US-108 (#50) |
| T | 85 | 0 |

72 trên 85 story đạt đủ sáu tiêu chí; 13 story còn trượt tiêu chí E hoặc S. Mỗi lỗi có Issue ghi blocker và điều kiện
`Ready`.

Lần chấm đầu có 77 story `Must`: 51 story đạt đủ, 17 story trượt tiêu chí I vì bốn phát hiện chung F1 tới F4, và US-045
trượt tiêu chí E vì thiếu luật thông báo cho đơn làm thêm. Sau khi sửa F1 tới F4 và thêm phần rule còn thiếu ở M1, M3 và
M4, các story đó đạt I và E. Tám story được thêm hoặc nâng lên `Must`: US-026, US-034, US-080, US-114 tới US-117 và
US-119.

## Cross-cutting findings

Priority chỉ được nâng khi một story `Must` cần thật tới story đó. Cột Evidence ghi chỗ cần.

| ID | Finding | Stories | Fix | Evidence |
|---|---|---|---|---|
| F1 | Ngày làm việc tính theo ca (BR-038), mà ca thuộc M3 (US-036, US-037). Ghi chú "MVP dùng `default_shift`" trong Summary của stories đã bị bỏ ở #39 cùng cột MVP | US-023, US-029, US-030, US-075, US-077 | Ghi lại trong Summary của stories và ở tham số `default_shift`: từ M2 tới khi M3 có quản lý ca, mọi nhân viên dùng `default_shift`. Sửa câu story của US-029 | Không đổi priority |
| F2 | Nhiều story `Must` cần thông báo trong hệ thống, nhưng danh sách thông báo và số chưa đọc chỉ có ở US-034, story `Should` của M2 | US-024, US-025, US-029, US-045, US-060, US-077, US-078, US-085, US-092, US-093, US-104, US-105, US-110 | Thêm US-114 ở M1 cho cơ chế chung (BR-213). US-034 chỉ còn thông báo về đơn nghỉ (BR-066) và lên `Must` | US-104 AC2 và US-105 AC2 ở M1 cần cơ chế chung, nên US-114 là `Must`. Sau khi tách, không story nào cần US-034; US-034 lên `Must` vì giá trị: thiếu nó thì người duyệt không biết có đơn mới cho tới lần nhắc sau `approval_reminder_days` ngày, trái với lợi ích của US-023, trong khi thông báo cùng loại cho đơn làm thêm và giải trình (US-116) là `Must` |
| F3 | Đổi đơn và gửi nhiều đơn một lần ở US-080 là `Should`, nhưng phương án nghỉ, thẻ đề xuất và đổi đơn từ chat cần tới | US-084, US-085, US-110 | Tách US-080 thành US-080, đổi đơn, và US-115, gửi nhiều đơn; cả hai lên `Must`. BR-152 ghi rõ một đơn đổi được thành nhiều đơn | Đổi đơn: US-110 AC3 dời đơn từ chat theo BR-207 đã `Confirmed`; US-085 AC1 chuyển phần thiếu phép của đơn đang chờ sang loại khác. Gửi nhiều đơn: US-084 AC1, phương án 3 ngày Kết hôn và 2 ngày Phép năm là hai đơn trong một lần xác nhận, theo BR-168; US-085 AC1 đổi một đơn thành hai đơn |
| F4 | HR duyệt thay ở US-026 là `Should`, nhưng US-077 AC2 cần | US-077 | Nâng US-026 lên `Must` | US-077 AC2 và BR-148 báo HR để duyệt thay; US-078 AC2 giao đơn cho HR khi người duyệt không có quản lý trực tiếp; BR-056 cho HR duyệt đơn của nhân viên không có quản lý trực tiếp. Sửa US-077 AC2 thành chỉ thông báo cho HR thì đơn vẫn treo |

## Results

✅ là Pass, ❌ là Fail. Cột Note ghi phát hiện chung đã sửa để story đạt, và Issue xử lý phần còn `Fail`.

| ID | Story | Milestone | I | N | V | E | S | T | Note |
|---|---|---|---|---|---|---|---|---|---|
| US-001 | Đăng nhập và đổi mật khẩu | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-002 | HR quản lý tài khoản người dùng | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-003 | HR gán và thu hồi vai trò HR | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-005 | HR quản lý danh mục chức danh | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-006 | HR tạo và sửa phòng ban | M1 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Gồm tạo phòng ban, đổi tên theo ngày hiệu lực và chuyển nhánh làm đổi quản lý trực tiếp. Đề xuất tách: tạo và đổi tên; chuyển nhánh (AC2, AC4). Tách ở #50 |
| US-008 | HR bổ nhiệm và thôi bổ nhiệm trưởng phòng ban | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-009 | Xem sơ đồ tổ chức hiện tại | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-011 | HR tiếp nhận nhân viên mới | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-012 | HR sửa hồ sơ nhân viên | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-013 | HR ghi nhận thay đổi công tác | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-014 | HR ghi nhận nghỉ việc | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Chạm ba module qua event; sát ngưỡng S |
| US-015 | HR quản lý hợp đồng lao động | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-017 | Nhân viên xem và cập nhật hồ sơ của mình | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-018 | Quản lý xem hồ sơ nhân viên trong phạm vi | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-020 | HR tìm và lọc danh sách nhân viên | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-022 | Nhân viên xem số dư phép năm | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-023 | Nhân viên gửi đơn nghỉ | M2 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Đạt I sau F1. Gồm tính số ngày theo buổi, lễ, ngày làm việc và kiểm số dư, chồng đơn, ngày lùi. Đề xuất tách: tính số ngày nghỉ (AC2, AC3); gửi đơn và kiểm luật (AC1, AC4 tới AC6). Tách ở #50 |
| US-024 | Nhân viên hủy đơn nghỉ | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2 |
| US-025 | Quản lý duyệt hoặc từ chối đơn nghỉ | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2 |
| US-026 | HR duyệt thay đơn nghỉ | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Lên `Must` ở F4 |
| US-028 | HR quản lý loại nghỉ | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-029 | HR quản lý lịch làm việc | M2 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Đạt I sau F1, F2. Gồm khai báo ngày lễ, ngày làm bù và tính lại đơn đã duyệt kèm thông báo. Đề xuất tách: khai báo lịch (AC1, AC4); tính lại đơn bị ảnh hưởng (AC2, AC3). Tách ở #50 |
| US-030 | Cộng phép năm hằng tháng | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F1. Actor thực hiện là Thời gian; lợi ích thuộc về nhân viên |
| US-031 | Chuyển phép tồn sang năm sau | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Như US-030, trừ F1 |
| US-032 | HR điều chỉnh số dư phép | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-034 | Thông báo về đơn nghỉ | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Lên `Must` ở F2; chỉ còn thông báo về đơn nghỉ, cơ chế chung ở US-114 |
| US-036 | HR quản lý ca làm việc | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-037 | HR gán ca cho nhân viên | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-038 | HR khai báo mã chấm công của nhân viên | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-039 | HR nhập file chấm công | M3 | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | Q-018 chưa có trả lời nên chưa biết định dạng file. Đề xuất định nghĩa một định dạng file chuẩn của hệ thống để HR chuyển file máy sang, hoặc chờ Q-018. Xử lý ở #47 |
| US-040 | Tính công từng ngày | M3 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Gồm khung giờ chấm, đi muộn, về sớm, thiếu chấm công, nghỉ nửa ngày và ngày không làm việc. Đề xuất tách: tính công ngày thường (AC1, AC5); trạng thái thiếu chấm công và vắng (AC2, AC3); kết hợp đơn nghỉ và ngày không làm việc (AC4, AC6). Tách ở #50 |
| US-041 | Nhân viên xem bảng công của mình | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-042 | Nhân viên gửi giải trình chấm công | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-043 | Quản lý duyệt giải trình chấm công | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-044 | Nhân viên đăng ký làm thêm giờ | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-045 | Quản lý duyệt đơn làm thêm giờ | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2. Đạt E sau khi có BR-214 cho thông báo của đơn làm thêm |
| US-047 | HR xử lý ngày thiếu chấm công | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-048 | HR chốt và mở lại bảng công tháng | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Sát ngưỡng S |
| US-050 | HR quản lý loại phụ cấp | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-051 | HR ghi lương và phụ cấp của nhân viên theo ngày hiệu lực | M4 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | AC5 phải tính lại bảng lương đã chốt để ra chênh lệch ước tính. Đề xuất tách: ghi bản ghi lương và kiểm mức sàn (AC1 tới AC4, AC6); chênh lệch của tháng đã chốt (AC5). Tách ở #50 |
| US-052 | HR ghi thông tin thuế và bảo hiểm của nhân viên | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-053 | HR quản lý người phụ thuộc | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-054 | HR quản lý tham số lương theo ngày hiệu lực | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-055 | HR tính bảng lương tháng | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Sát ngưỡng S; tiền làm thêm, bảo hiểm và thuế nằm ở US-056 tới US-058 |
| US-056 | Tính tiền làm thêm giờ và làm ban đêm | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-057 | Tính bảo hiểm bắt buộc | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-058 | Tính thuế TNCN | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-059 | HR thêm khoản điều chỉnh vào phiếu lương | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-060 | HR chốt bảng lương | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2 |
| US-061 | Nhân viên xem phiếu lương | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-064 | Xem trang tổng quan nhân sự | M5 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Lần chấm trước Fail tiêu chí I vì phạm vi MVP; với v1.0, M3 và M4 làm trước M5 nên đạt |
| US-065 | Xem báo cáo biến động nhân sự | M5 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-067 | Xem báo cáo nghỉ phép | M5 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-068 | Xem báo cáo chấm công | M5 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | AC4 là xếp hạng do báo cáo cố định, không do AI |
| US-069 | Xem báo cáo chi phí lương | M5 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-073 | HR quản lý danh mục lý do nghỉ | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-074 | Nhân viên chọn lý do nghỉ theo danh mục | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-075 | Cảnh báo đơn làm phòng ban thiếu người | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F1: mức phủ tính theo buổi làm việc của ca |
| US-077 | Nhắc người duyệt và báo HR khi đơn chờ lâu | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F1, F2 và F4 |
| US-078 | Người duyệt thay khi người duyệt đang nghỉ | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2 |
| US-080 | Nhân viên đổi đơn | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Tách và lên `Must` ở F3. AC4 nêu màn hình và nút theo BR-207, quyết định của chủ dự án, nên vẫn đạt N |
| US-082 | Tạo đơn nghỉ bằng câu mô tả | M6 | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | Độ chính xác khi diễn giải câu tiếng Việt chờ spike ghi ở brief; ước lượng được sau spike #48. Sát ngưỡng S với giả định phần chung của AI là Task riêng |
| US-083 | AI kiểm mô tả của đơn khớp lý do nghỉ | M6 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | AC3 kiểm bằng eval |
| US-084 | Nhân viên nhận phương án nghỉ đề xuất | M6 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Đạt I sau F3. Đề xuất tách: core sinh phương án hợp lệ kèm xem trước (AC1, AC3, AC5); AI chọn theo mong muốn (AC2, AC4). Tách ở #50 |
| US-085 | Nhận giải thích và đề xuất khi đơn gặp tình huống | M6 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Đạt I sau F2, F3. Đề xuất tách theo tình huống: thiếu phép lúc duyệt (AC1); đổi lịch làm việc (AC2, AC3). Tách ở #50 |
| US-088 | Người duyệt xem tóm tắt tác động và phương án thay thế | M6 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | AC2 kiểm bằng eval |
| US-090 | Xem thẻ cảnh báo trên trang tổng quan | M5 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Gồm cơ chế tính và lưu tín hiệu, thẻ cảnh báo và 10 loại tín hiệu. Đề xuất tách: cơ chế và thẻ với một nhóm tín hiệu; thêm từng nhóm còn lại. Tách ở #50 |
| US-091 | Xem chi tiết và phân rã của một tín hiệu | M5 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Mỗi loại tín hiệu có cách phân rã riêng. Đề xuất tách: phân rã chi phí lương; phân rã các loại còn lại. Tách ở #50 |
| US-092 | Nhận thông báo khi có tín hiệu mức Cao | M5 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2 |
| US-093 | Đánh giá, đóng hoặc tắt thẻ cảnh báo | M5 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2 |
| US-096 | AI gom tín hiệu thành insight | M6 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Dùng lại phần chung của AI |
| US-097 | AI giải thích insight từ phân rã | M6 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | AC3 kiểm bằng eval |
| US-101 | HR đăng và cập nhật quy chế theo phiên bản | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-102 | Đọc và tìm quy chế | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-104 | Gửi câu hỏi cho HR và nhận trả lời | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2: cơ chế thông báo ở US-114, cùng M1 |
| US-105 | HR trả lời câu hỏi và được nhắc khi câu hỏi chờ lâu | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2: cơ chế thông báo ở US-114, cùng M1 |
| US-107 | Hỏi quy chế với AI HR Assistant | M6 | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | Độ chính xác trả lời quy chế chờ spike #49. Đề xuất tách: khung chat và hỏi đáp với công cụ tra quy chế (AC1, AC2, AC5); phiên bản và chỗ khác cấu hình (AC3, AC4); lưu và xóa hội thoại (AC6). Tách ở #50 |
| US-108 | Tra dữ liệu qua AI HR Assistant | M6 | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Nhiều công cụ đọc và luật lọc. Đề xuất tách: dữ liệu của mình (AC2, AC5); dữ liệu phạm vi và lịch nhóm (AC1, AC3, AC4); an toàn và giới hạn (AC6 tới AC8). Tách ở #50 |
| US-110 | Bắt đầu xin, đổi hoặc hủy đơn nghỉ từ chat | M6 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Đạt I sau F2, F3 |
| US-112 | Chuyển câu hỏi cho HR kèm tóm tắt hội thoại | M6 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| US-114 | Nhận và đọc thông báo trong hệ thống | M1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Thêm ở F2 |
| US-115 | Nhân viên gửi nhiều đơn trong một lần | M2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Tách từ US-080 ở F3. AC3 cần US-080, cùng M2 |
| US-116 | Thông báo và nhắc về đơn làm thêm và giải trình | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Thêm khi rà rule tự động. Không cần hạn chốt công của US-118 (`Should`): AC5 kiểm trường hợp chưa đặt hạn |
| US-117 | Nhân viên được báo ngày chấm công chưa xử lý | M3 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Thêm khi rà rule tự động. Luật chạy sau khi công đã tính nên không chờ định dạng file của Q-018 |
| US-119 | HR rà bản ghi lương khi lương tối thiểu vùng thay đổi | M4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Thêm khi rà rule tự động. AC5 cần US-055, cùng M4 |
