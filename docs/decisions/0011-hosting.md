# ADR-0011: Nơi chạy staging và production

- **Status:** Proposed
- **Date:** 2026-11-03
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Drivers:** QA-005; ràng buộc hạ tầng $10–25 mỗi tháng (Q-009), một người làm, luật bảo vệ dữ liệu cá nhân
- **Related:** [ARCHITECTURE](../../ARCHITECTURE.md#architecture-drivers), Q-009, Q-035, #8, #14, ADR-0007, ADR-0009

## Context

- Cần chạy một backend, một tiến trình job theo lịch, web client và PostgreSQL managed (ADR-0007, ADR-0009), cho
  staging và production.
- Ngân sách hạ tầng khoảng $10–25 mỗi tháng (Q-009); ngân sách dịch vụ AI tính riêng (Q-031).
- Mất tối đa 24 giờ dữ liệu, chạy lại trong 4 giờ (QA-005).
- Người dùng ở Việt Nam; máy chủ ở Singapore cho độ trễ thấp hơn châu Âu hay Mỹ.
- Chưa rõ lưu dữ liệu nhân viên ở máy chủ ngoài Việt Nam cần thủ tục gì theo Luật Bảo vệ dữ liệu cá nhân 91/2025 và
  Nghị định 356/2025 (Q-035). Câu trả lời có thể loại các phương án ở nước ngoài.
- Giá dưới đây tra ngày 2026-11-03 từ trang giá và bài so sánh, chưa tính thuế; kiểm lại trên trang giá chính thức trước
  khi chuyển ADR sang `Accepted`.

## Decision

Chưa đề xuất: chờ trả lời Q-035. Nếu được lưu ở Singapore, phương án PaaS ở dòng đầu hợp ràng buộc một người làm nhất;
nếu phải lưu ở Việt Nam, so tiếp các nhà cung cấp cloud trong nước.

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| PaaS, ví dụ Render ở Singapore: web service khoảng $7 và PostgreSQL gói nhỏ nhất khoảng $6 mỗi tháng | Deploy từ GitHub; PostgreSQL managed có backup; không phải vá hệ điều hành | Tiến trình job là service thứ hai, tốn thêm; gói DB nhỏ chỉ có 256 MB RAM; dữ liệu ở nước ngoài | Ngân sách: khoảng $13–20 cho production; QA-005: theo backup của gói, cần kiểm; một người: đạt |
| PaaS tính theo mức dùng, ví dụ Railway: gói Hobby $5, đã gồm $5 mức dùng | Rẻ khi ít dùng; app, job và DB trong một project | Chi phí khó đoán trước; chưa xác nhận được vùng Singapore và cách backup DB | Ngân sách: đạt khi tải thấp; QA-005: chưa rõ |
| VPS tự quản, ví dụ Hetzner ở Singapore từ khoảng €6 mỗi tháng, chạy app và PostgreSQL bằng container | Rẻ nhất cho cùng tài nguyên; toàn quyền cấu hình | Tự vá hệ điều hành, tự backup và diễn tập khôi phục; một máy hỏng là dừng cả hệ thống | Ngân sách: đạt; QA-005: tự làm, rủi ro cao nhất; một người: tốn công vận hành |
| Cloud trong nước, ví dụ máy ảo và DB của một nhà cung cấp Việt Nam | Dữ liệu nằm ở Việt Nam, đơn giản hóa Q-035 | Chưa tra giá và mức managed của PostgreSQL; ít tích hợp deploy từ GitHub | Ngân sách: chưa biết; luật dữ liệu: đạt nhất |

## Consequences

- **Easier:** chọn sau Q-035 thì không phải chuyển dữ liệu giữa các nước về sau.
- **Harder:** Container và Deployment của ARCHITECTURE chưa vẽ xong được tới khi chọn.
- **Follow-up:** trả lời Q-035; kiểm giá và chính sách backup trên trang chính thức; dựng staging ở #14.

## Revisit when

Chi phí thực vượt $25 mỗi tháng; Q-035 được trả lời khác giả định; hoặc QA-005 không đạt khi diễn tập khôi phục.
