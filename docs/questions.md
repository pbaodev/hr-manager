# Questions and assumptions

- **Updated:** [YYYY-MM-DD]

> Ghi mọi điều chưa biết ở đây, kể cả câu tự hỏi mình. Câu trả lời từ người dùng, tài liệu hay thử nghiệm được chép vào
> đây, kèm nguồn và ngày. Nhiều người cần hỏi cùng một câu thì gửi kèm mã `Q-xxx` để dễ đối chiếu. Dòng in nghiêng là ví
> dụ, xóa khi điền.

## Questions

- **Priority:** `blocks-design` (chưa có trả lời thì chưa thiết kế được phần liên quan), `blocks-build` (cần trước khi
  code phần liên quan), `nice-to-know` (không chặn việc gì).
- **Status:** `Open` → `Asked` → `Answered`, hoặc `Assumed` khi đã chuyển thành assumption.

| ID | Question | Why it matters | Priority | Ask | Status | Answer (source, date) |
|---|---|---|---|---|---|---|
| *Q-001* | *Có cho đặt lịch lặp hằng tuần không?* | *Đổi entity Booking và luật trùng lịch* | *blocks-design* | *Trưởng nhóm hành chính* | *Answered* | *Có, tối đa 12 tuần (trưởng nhóm hành chính, 2026-11-03)* |

## Assumptions

Câu hỏi chưa có trả lời mà vẫn phải làm tiếp thì ghi thành assumption, kèm cách kiểm và hậu quả nếu sai. Assumption là
con số thì đặt trong config.

| ID | From | Assumption | Impact if wrong | Check by | Confirmed |
|---|---|---|---|---|---|
| *A-001* | *Q-002* | *Mỗi phòng chỉ thuộc một tòa nhà* | *Thêm entity Building; đổi bộ lọc tìm phòng* | *Hỏi quản trị trước M2* | *No* |
