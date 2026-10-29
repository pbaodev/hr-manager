# Brief: [tên dự án]

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [questions](questions.md) · [requirements](requirements.md) · [decisions](decisions/README.md)

> Giữ trong một trang. Brief trả lời câu hỏi có nên làm không và làm theo hướng nào. Yêu cầu chi tiết nằm ở
> requirements; thiết kế nằm ở ARCHITECTURE và ADR. Điều chưa xác nhận thì ghi `(assumption)`. Dòng in nghiêng là ví
> dụ, xóa khi điền.

## Origin

[Ý tưởng đến từ đâu: vấn đề tự gặp, người quen nhờ, đề bài. Có đề bài hay yêu cầu gốc thì chép nguyên văn hoặc dẫn
link, và không sửa phần đó về sau; bổ sung thì ghi thêm kèm ngày.]

## Problem

[Ai gặp vấn đề gì, trong hoàn cảnh nào, hậu quả ra sao. 2–3 câu, kèm nguồn hoặc số liệu nếu có.]

## Users

| User | Need | Current workaround |
|---|---|---|
| *Thành viên văn phòng* | *Có phòng họp đúng giờ cho nhóm* | *Nhắn nhóm chat để giữ phòng; hai nhóm trùng phòng khoảng 2 lần mỗi tuần* |

## Alternatives

| Option | Why not enough |
|---|---|
| *Lịch chung trên Google Calendar* | *Không chặn đặt trùng; ai cũng sửa được lịch của người khác* |
| *Tự làm* | *[lý do; "để luyện thiết kế hệ thống" là lý do hợp lệ, ghi thẳng ra]* |

## Solution

[Sản phẩm giúp người dùng thế nào, 2–3 câu. Chưa chọn công nghệ ở đây.]

- **AI role:** [AI làm phần nào, phần nào do code hoặc người quyết định; bỏ dòng này khi không có tính năng AI]

## Scope

- **In:** [những gì bản đầu phải có]
- **Out:** [những gì chưa làm, kèm lý do ngắn]
- **Constraints:** [deadline, ngân sách mỗi tháng, nền tảng bắt buộc, yêu cầu pháp lý hoặc bảo mật]

## Success metrics

| Metric | Baseline | Target | Measured by |
|---|---|---|---|
| *Số lần trùng phòng mỗi tuần* | *Khoảng 2* | *0* | *Hỏi trưởng nhóm hành chính sau 4 tuần dùng* |

## Risks

| Risk | Type | Mitigation or spike |
|---|---|---|
| *Không nhóm nào ngoài nhóm mình dùng* | *Product* | *Hỏi 3 nhóm khác trước khi làm M2* |
| *Đồng bộ hai chiều với Google Calendar phức tạp hơn dự kiến* | *Technical* | *Spike, time box 1 ngày* |

## Decision

[Go | Pivot | Stop] · [YYYY-MM-DD]. [Một câu lý do.]
