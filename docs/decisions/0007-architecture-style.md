# ADR-0007: Modular monolith gồm một backend và một web client

- **Status:** Accepted
- **Date:** 2026-11-03
- **Reviewed:** 2026-11-03: chủ dự án chọn phương án ở #8; chưa review nguội, chưa AI review
- **Drivers:** QA-001, QA-003, QA-007; ràng buộc một người làm, hạ tầng $10–25 mỗi tháng
- **Related:** [ARCHITECTURE](../../ARCHITECTURE.md#architecture-drivers), #8, ADR-0008, ADR-0011

## Context

Hệ thống phục vụ một công ty tới 300 nhân viên (A-011), có sáu module M1 tới M6 dùng chung dữ liệu nhân sự. Luật quan
trọng nhất đi qua nhiều module trong một thao tác: duyệt đơn nghỉ trừ số dư phép và kiểm ngưỡng nhân sự (QA-001), tính
lương đọc công, phép, hợp đồng và bản ghi lương. Mọi thao tác phải kiểm quyền theo vai trò và phạm vi phòng ban ở
backend (QA-003). AI chỉ đọc qua công cụ chạy bằng phiên của người dùng và không có đường ghi riêng (QA-007, BR-198).
Một người làm cùng coding agent, nên số thứ phải deploy và theo dõi càng ít càng tốt.

## Decision

Chủ dự án chọn ngày 2026-11-03: một backend chia module theo nghiệp vụ (tổ chức và nhân sự, nghỉ phép, chấm công,
lương, báo cáo, AI) cùng một web client, deploy như một ứng dụng. Việc chạy theo lịch là một tiến trình của cùng
codebase, đọc và ghi cùng DB. Module chỉ gọi nhau qua interface public; dependency rule ghi ở
[components](../design/components.md).

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| Modular monolith: một backend và một web client | Một transaction phủ được thao tác đi qua nhiều module; kiểm quyền ở một chỗ; một lần deploy | Ranh giới module chỉ giữ được khi có dependency rule và cách kiểm | QA-001, QA-003, QA-007: đạt bằng code backend; ràng buộc một người: đạt |
| Client và BaaS, ví dụ DB, auth và function của một dịch vụ | Có sẵn auth, DB, API; ra nhanh với phần CRUD | Phạm vi theo cây phòng ban và ngày hiệu lực khó viết bằng row-level policy; luật lương nằm rải trong function; AI phải gọi qua function riêng | QA-003: đạt nếu policy đúng cho mọi bảng, khó test; QA-001: cần function chạy transaction |
| Serverless functions cho từng thao tác | Scale-to-zero, chi phí thấp khi ít dùng | Cold start; job theo lịch và tính lương 300 phiếu cần chạy dài; khó chạy local | QA-001: đạt nếu mỗi function tự giữ transaction; ràng buộc một người: thêm việc vận hành |

## Consequences

- **Easier:** thao tác nhiều module trong một transaction; test tích hợp chạy một tiến trình; agent đọc một codebase.
- **Harder:** phải tự giữ ranh giới module; một lỗi làm treo backend thì mọi module cùng dừng.
- **Follow-up:** vẽ Container khi ADR-0008 và ADR-0011 được chọn; ghi dependency rule và cách kiểm ở components.

## Revisit when

Số nhân viên vượt 1.000 và tính lương hay nhập file phải chạy nền lâu (A-011); hoặc một module cần deploy riêng.
