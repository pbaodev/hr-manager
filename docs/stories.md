# Stories: [tên dự án]

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [requirements](requirements.md) · [domain](domain.md) · [ui-flow](ui-flow.md) · [SPEC](SPEC.md) ·
  [analysis guide](playbook/analysis.md)

> Điền ở Phase 2; cập nhật ở mỗi Feature loop. Đây là nguồn chính cho user story và acceptance criteria. Actor, use
> case và quality attribute nằm ở requirements; luật và edge case nằm ở domain, file này dẫn mã thay vì viết lại. Trạng
> thái, ước lượng và thứ tự làm nằm trên tracker, không ghi ở đây. Cách viết story nằm ở analysis guide; điều kiện để
> story được bắt đầu là Definition of Ready trong [working-agreement](playbook/working-agreement.md). Dòng in nghiêng là
> ví dụ, xóa khi điền.

## Summary

- **Priority:** `Must` khi thiếu story đó thì bản phát hành vô nghĩa; `Should`, `Could` cho phần còn lại. Phần không
  làm ghi vào Non-goals trong requirements.
- **Feature:** Issue Feature trên tracker chứa story; điền khi tạo Issue ở Phase 4.

| ID | Story | Priority | Milestone | Feature |
|---|---|---|---|---|
| *US-001* | *Đặt phòng theo khung giờ* | *Must* | *M1* | *[#issue]* |
| *US-004* | *Gợi ý phòng từ câu mô tả* | *Could* | *M3* | *[#issue]* |

## Details

Mỗi story một mục như dưới. Mỗi tiêu chí kiểm được bằng một test hoặc một bước thử tay; có ít nhất một nhánh thất bại.

### US-001: Đặt phòng theo khung giờ

**Story:** *Là thành viên, tôi muốn đặt phòng theo khung giờ để nhóm có chỗ họp.*

**Links:** *UC-001 · BR-001, BR-002 · EC-001 · SCR-001, SCR-002*

**Acceptance criteria**

- *AC1: Given phòng A trống 9:00–10:00, when thành viên đặt phòng A 9:00–10:00, then lịch được tạo và phòng A hiện bận
  trong khung giờ đó.*
- *AC2: Given phòng A có lịch 9:00–10:00, when đặt phòng A 9:30–10:30, then bị từ chối với lý do trùng lịch và không có
  lịch mới (BR-001).*
- *AC3: Given khung giờ dài hơn `max_booking_hours`, when đặt, then bị từ chối và báo giới hạn (BR-002).*

### US-004: Gợi ý phòng từ câu mô tả

**Story:** *Là thành viên, tôi muốn mô tả cuộc họp bằng một câu để được gợi ý phòng phù hợp.*

**Links:** *BR-003 · SCR-003 · [AI component](design/ai.md)*

**Acceptance criteria**

- *AC1: Given câu "họp 6 người chiều thứ Năm, cần màn hình", when gửi, then nhận tối đa 3 gợi ý đúng sức chứa và thiết
  bị.*
- *AC2: Given câu không có đủ thông tin để hiểu, when gửi, then chuyển sang form thường và không đoán.*
