# Requirements: [tên dự án]

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [brief](brief.md) · [stories](stories.md) · [domain](domain.md) · [SPEC](SPEC.md) ·
  [analysis guide](playbook/analysis.md)

> Điền ở Phase 2; cập nhật ở mỗi Feature loop. File này ghi hệ thống phải làm gì và tốt tới mức nào, không ghi làm bằng
> gì: không nhắc framework, DB hay dịch vụ dùng để xây hệ thống. Hệ thống ngoài mà sản phẩm phải nối tới thì ghi tên
> trong Actors. User story và acceptance criteria nằm ở stories. Luật nghiệp vụ, entity và edge case nằm ở domain;
> file này dẫn mã `US-xxx`, `BR-xxx`, `EC-xxx` thay vì viết lại. Cách viết từng mục nằm ở analysis guide. Dòng in
> nghiêng là ví dụ, xóa khi điền.

## Goal

[Baseline hoặc bản phát hành này giúp người dùng đạt được gì, 1–2 câu. Bối cảnh nằm ở brief.]

## Actors

| Actor | Type | Goals | Permissions |
|---|---|---|---|
| *Thành viên* | *Người* | *Đặt phòng họp cho nhóm mình* | *Đặt và hủy lịch của mình; xem lịch của mọi phòng* |
| *Quản trị* | *Người* | *Giữ danh sách phòng đúng* | *Thêm, sửa, khóa phòng; hủy lịch bất kỳ* |
| *Google Calendar* | *Hệ thống ngoài* | *Nhận sự kiện khi lịch đặt thay đổi* | *—* |

### Permission matrix

Dùng khi có từ hai vai trò người trở lên. Mỗi thao tác trong story là một dòng; mỗi actor người là một cột. Quyền được
kiểm ở backend, kể cả khi giao diện đã ẩn nút.

| Operation | Thành viên | Quản trị |
|---|---|---|
| *Đặt phòng (US-001)* | *✅* | *✅* |
| *Hủy lịch (US-003)* | *✅ chỉ lịch của mình* | *✅ mọi lịch* |
| *Khóa phòng (US-006)* | *❌* | *✅* |

## User stories

Story và acceptance criteria nằm ở [stories.md](stories.md).

## Use cases

Chỉ viết cho story có nhiều bước, nhiều nhánh, nhiều actor, hoặc có tác động khó đảo ngược. Story CRUD đơn giản không
cần use case.

### UC-001: [động từ + danh từ]

- **Actor:** [actor chính; actor phụ nếu có] · **Stories:** [US-xxx]
- **Trigger:** [sự kiện bắt đầu]
- **Preconditions:** [điều phải đúng trước khi bắt đầu]
- **Main flow:**
  1. [Actor làm gì]
  2. [Hệ thống phản hồi gì]
- **Alternative flows:** [`2a`. Khi …: …]
- **Exceptions:** [`3a`. Khi … thì …; dẫn `EC-xxx`]
- **Postconditions:** [điều đúng sau khi kết thúc, kể cả khi thất bại]

## Quality attributes

Mỗi dòng là một scenario có số đo. Importance và Difficulty xếp theo `H`, `M`, `L`; các dòng `H/H` và `H/M` là
architecture driver trong [ARCHITECTURE.md](../ARCHITECTURE.md). Số đo phỏng đoán thì ghi `(assumption)`.

Cột Verify by ghi cách đo dự kiến. Scenario chưa có cách đo thì chưa phải quality attribute. Test hay lần đo cụ thể
ghi ở Traceability trong [SPEC](SPEC.md).

| ID | Attribute | Scenario | Measure | Verify by | Importance / Difficulty |
|---|---|---|---|---|---|
| *QA-001* | *Performance* | *Thành viên mở lịch tuần của một phòng khi có 50 người dùng cùng lúc* | *p95 < 500 ms (assumption)* | *Load test trên staging* | *H / M* |
| *QA-002* | *Data integrity* | *Hai người cùng đặt một phòng, cùng khung giờ, trong cùng một giây* | *Đúng một lịch được tạo; người kia nhận lỗi trùng lịch* | *Integration test gửi hai request song song* | *H / H* |
| *QA-003* | *Cost* | *Vận hành với 100 người dùng hoạt động mỗi tháng* | *Chi phí hạ tầng < $10 mỗi tháng* | *Hóa đơn hosting sau tháng đầu* | *M / L* |

## Non-goals

- [phần không làm trong baseline hoặc bản phát hành này, kèm lý do ngắn]

## Sign-off

Chỉ dùng cho dự án loại Client delivery. Bên nhận xác nhận phạm vi baseline trước khi sang Phase 3; sau mốc này, đổi
story hay luật đã chốt đi theo [change-control.md](playbook/change-control.md).

| Name | Role | Date | Scope confirmed | Result |
|---|---|---|---|---|
| [họ tên] | [bên nhận / người đại diện] | [YYYY-MM-DD] | [stories, domain, requirements tại commit nào] | [Accepted / Cần sửa] |
