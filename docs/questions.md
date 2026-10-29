# Questions and assumptions

- **Updated:** 2026-10-30

> Ghi mọi điều chưa biết ở đây, kể cả câu tự hỏi mình. Câu trả lời từ người dùng, tài liệu hay thử nghiệm được chép vào
> đây, kèm nguồn và ngày. Nhiều người cần hỏi cùng một câu thì gửi kèm mã `Q-xxx` để dễ đối chiếu.

## Questions

- **Priority:** `blocks-design` (chưa có trả lời thì chưa thiết kế được phần liên quan), `blocks-build` (cần trước khi
  code phần liên quan), `nice-to-know` (không chặn việc gì).
- **Status:** `Open` → `Asked` → `Answered`, hoặc `Assumed` khi đã chuyển thành assumption.

| ID | Question | Why it matters | Priority | Ask | Status | Answer (source, date) |
|---|---|---|---|---|---|---|
| Q-001 | Chỗ đau lớn nhất của HR ở công ty mục tiêu là gì: nghỉ phép, chấm công, lương hay hồ sơ? | Xác nhận Problem của brief và milestone đầu tiên công ty dùng được | blocks-design | HR công ty mục tiêu | Assumed | Xem A-001 |
| Q-002 | Hiện nay công ty xin nghỉ, duyệt nghỉ và theo dõi số dư phép bằng cách nào, và mất bao lâu? | Hiện trạng trong brief; luồng duyệt; giá trị baseline của success metrics | blocks-design | HR công ty mục tiêu | Assumed | Xem A-002 |
| Q-003 | Công ty có bao nhiêu nhân viên, bao nhiêu phòng ban và mấy cấp quản lý? | Cơ cấu tổ chức, phân quyền và quality attribute về tải | blocks-design | HR công ty mục tiêu | Open | |
| Q-004 | Quy chế nghỉ phép của công ty khác Bộ luật Lao động ở đâu: số ngày phép, cộng dồn sang năm sau, nghỉ nửa ngày, cấp duyệt? | Business rule của M2 | blocks-design | HR công ty mục tiêu | Open | |
| Q-005 | Công ty chấm công bằng gì: máy chấm công, app hay bảng tính? Hệ thống có phải nhập dữ liệu từ máy chấm công không? | Hệ thống ngoài và luồng dữ liệu của M3 | blocks-design | HR công ty mục tiêu | Open | |
| Q-006 | Công ty tính lương thế nào: gồm những khoản lương và phụ cấp nào, ai tính BHXH và thuế TNCN, trả lương ngày nào? | Phạm vi và business rule của M4 | blocks-design | HR hoặc kế toán công ty mục tiêu | Open | |
| Q-007 | Ban giám đốc cần những báo cáo nào, và xem bao lâu một lần? | Phạm vi của M5 | blocks-design | Ban giám đốc công ty mục tiêu | Open | |
| Q-008 | Số hiệu, mức giảm trừ gia cảnh và biểu thuế của Luật Thuế TNCN sửa đổi là gì? Tỷ lệ đóng BHYT, BHTN và lương tối thiểu vùng đang hiệu lực là bao nhiêu? | Nguồn của business rule ở M4, xem [research](research.md#legal-sources) | blocks-design | Cơ sở dữ liệu quốc gia về văn bản pháp luật | Open | |
| Q-009 | Ngân sách hạ tầng mỗi tháng là bao nhiêu? | Chọn hosting ở Phase 3 | blocks-design | Chủ dự án, khi so sánh chi phí trong ADR hosting ở Phase 3 | Open | |
| Q-010 | Công ty có đồng ý dùng thử không, và với điều kiện gì về dữ liệu nhân viên? | Thời điểm dùng dữ liệu thật; success metrics dài hạn | nice-to-know | Ban giám đốc công ty mục tiêu | Open | |

## Assumptions

Câu hỏi chưa có trả lời mà vẫn phải làm tiếp thì ghi thành assumption, kèm cách kiểm và hậu quả nếu sai. Assumption là
con số thì đặt trong config.

| ID | From | Assumption | Impact if wrong | Check by | Confirmed |
|---|---|---|---|---|---|
| A-001 | Q-001 | Chỗ đau lớn nhất là xin và duyệt nghỉ đang rời rạc | Viết lại Problem của brief; bản đầu tiên công ty dùng được không còn là M2 | Hỏi HR công ty trước khi requirements `Accepted` | No |
| A-002 | Q-002 | Nhân viên xin nghỉ qua Zalo hoặc nói miệng; quản lý duyệt miệng; HR theo dõi số dư phép bằng bảng tính | Sửa Users và Alternatives của brief; sửa luồng duyệt trong requirements | Hỏi HR công ty trước khi requirements `Accepted` | No |
