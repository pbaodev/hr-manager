# INVEST review: MVP stories

- **Status:** Draft
- **Updated:** 2026-10-30
- **Reviewed:** [YYYY-MM-DD: chủ dự án đọc lại kết quả chấm]
- **Related:** [stories](stories.md) · [requirements](requirements.md) · [README](../../README.md)

> Kết quả chấm 32 story có ✅ ở cột MVP của [stories](stories.md#summary) theo sáu tiêu chí INVEST. Agent chấm dựa trên
> câu story và acceptance criteria; chủ dự án đọc lại trước khi chuyển `Accepted`. Story `Fail` được ghi lý do và cách
> sửa đề xuất. Sửa story là việc của Issue riêng, không làm trong file này.

## Rubric

| Criterion | Pass khi | Fail khi |
|---|---|---|
| **I**ndependent | Làm và kiểm được trong MVP mà không cần story ngoài MVP. Cần dữ liệu do story làm trước tạo ra vẫn tính là Pass | Có acceptance criterion cần dữ liệu hay chức năng của story ngoài MVP |
| **N**egotiable | Story nói người dùng cần gì, không áp đặt cách làm như màn hình, công nghệ hay thuật toán | Story hoặc AC mô tả cách cài đặt |
| **V**aluable | Có vai trò rõ và vế "để ..." nói lợi ích cho vai trò đó | Không thấy ai được lợi, hoặc chỉ là việc kỹ thuật |
| **E**stimable | Luật liên quan đã có mã `BR-xxx`, edge case đã có mã `EC-xxx`; không còn câu hỏi mở trong [questions](../project/questions.md) chặn story | Còn chỗ mơ hồ làm không ước lượng được |
| **S**mall | Agent ước lượng làm xong backend, frontend và test trong một PR, khoảng 3 ngày công trở xuống | Có từ hai phần việc độc lập trở lên, nên tách |
| **T**estable | Mỗi AC viết dạng Given, When, Then với kết quả kiểm được | Có AC không kiểm được, hoặc kết quả không đo được |

## Summary

| Criterion | Pass | Fail |
|---|---|---|
| I | 30 | 2: US-064, US-070 |
| N | 32 | 0 |
| V | 32 | 0 |
| E | 32 | 0 |
| S | 29 | 3: US-006, US-023, US-029 |
| T | 32 | 0 |

27 trên 32 story đạt đủ sáu tiêu chí; 5 story có một tiêu chí `Fail`.

## Results

✅ là Pass, ❌ là Fail.

| ID | Story | I | N | V | E | S | T | Note |
|---|---|---|---|---|---|---|---|---|
| US-001 | Đăng nhập và đổi mật khẩu | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-002 | HR quản lý tài khoản người dùng | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-003 | HR gán và thu hồi vai trò HR | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-005 | HR quản lý danh mục chức danh | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-006 | HR tạo và sửa phòng ban | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Gồm tạo phòng ban, đổi tên theo ngày hiệu lực và chuyển nhánh làm đổi quản lý trực tiếp. Đề xuất tách: tạo và đổi tên; chuyển nhánh (AC2, AC4) |
| US-008 | HR bổ nhiệm và thôi bổ nhiệm trưởng phòng ban | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-009 | Xem sơ đồ tổ chức hiện tại | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-011 | HR tiếp nhận nhân viên mới | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-012 | HR sửa hồ sơ nhân viên | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-013 | HR ghi nhận thay đổi công tác | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-014 | HR ghi nhận nghỉ việc | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Chạm ba module qua event; sát ngưỡng S |
| US-015 | HR quản lý hợp đồng lao động | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-016 | HR xem hợp đồng sắp hết hạn | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-017 | Nhân viên xem và cập nhật hồ sơ của mình | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-018 | Quản lý xem hồ sơ nhân viên trong phạm vi | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-020 | HR tìm và lọc danh sách nhân viên | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-022 | Nhân viên xem số dư phép năm | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-023 | Nhân viên gửi đơn nghỉ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Gồm tính số ngày theo buổi, lễ, ngày làm việc và kiểm số dư, chồng đơn, ngày lùi. Đề xuất tách: tính số ngày nghỉ (AC2, AC3); gửi đơn và kiểm luật (AC1, AC4 tới AC6) |
| US-024 | Nhân viên hủy đơn nghỉ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-025 | Quản lý duyệt hoặc từ chối đơn nghỉ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-026 | HR duyệt thay đơn nghỉ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-027 | Quản lý xem lịch nghỉ của nhóm | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-028 | HR quản lý loại nghỉ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-029 | HR quản lý lịch làm việc | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | Gồm khai báo ngày lễ, ngày làm bù và tính lại đơn đã duyệt kèm thông báo. Đề xuất tách: khai báo lịch (AC1, AC4); tính lại đơn bị ảnh hưởng (AC2, AC3). Câu story dẫn tới US-036 ngoài MVP; MVP dùng `default_shift` theo ghi chú ở Summary của stories |
| US-030 | Cộng phép năm hằng tháng | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Actor thực hiện là Thời gian; lợi ích thuộc về nhân viên |
| US-031 | Chuyển phép tồn sang năm sau | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Như US-030 |
| US-032 | HR điều chỉnh số dư phép | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-034 | Thông báo về đơn nghỉ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-064 | Xem trang tổng quan nhân sự | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ | AC2 cần số ngày chưa xử lý, trạng thái bảng công và bảng lương của M3, M4. Summary của stories đã ghi MVP chưa có các số này, nhưng AC chưa tách. Đề xuất tách AC2 thành phần MVP và phần M3, M4 |
| US-065 | Xem báo cáo biến động nhân sự | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-067 | Xem báo cáo nghỉ phép | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| US-070 | Xuất báo cáo ra bảng tính | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ | AC2 nói về báo cáo chi phí lương (US-069), ngoài MVP. Đề xuất ghi AC2 áp dụng từ M4 |
