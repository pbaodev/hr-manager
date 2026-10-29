# ADR-0001: Modular monolith gồm một backend và một SPA

- **Status:** Accepted
- **Date:** 2026-10-30
- **Reviewed:** 2026-10-30: chủ dự án chọn phương án
- **Drivers:** QA-001, QA-003, QA-004; một người làm cùng coding agent; ngân sách hạ tầng $10–25 mỗi tháng (Q-009)
- **Related:** [requirements](../requirements.md#quality-attributes), [research](../research.md#decomposition), A-011

## Context

Hệ thống có năm module nghiệp vụ M1–M5 với nhiều luật trải trên nhiều aggregate, như số dư phép, chốt kỳ công và chốt
bảng lương. Quy mô thiết kế là 300 nhân viên và 30 người dùng cùng lúc (A-011), nên một ứng dụng đủ tải. Một người vận
hành, nên mỗi service thêm vào là thêm chi phí deploy, giám sát và debug.

## Decision

- Một backend duy nhất, deploy một lần, chia module theo nghiệp vụ: `identity`, `organization`, `employees`, `leave`,
  `attendance`, `payroll`, `reporting`. Các phần dùng chung như lịch làm việc, tham số, nhật ký và thông báo nằm trong
  module `shared`.
- Module chỉ gọi nhau qua interface public của module; không đọc bảng của module khác. Quy tắc phụ thuộc chi tiết ghi ở
  [components](../design/components.md).
- Frontend là một SPA, được build thành file tĩnh và do chính backend phục vụ trên cùng domain (ADR-0004, ADR-0005).
- Job theo lịch của actor Thời gian, như cộng phép hay mở kỳ công, là lệnh của cùng codebase, chạy theo cron (ADR-0005).

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| Modular monolith | Một deploy, một DB, transaction trải nhiều bảng dễ; debug một chỗ | Ranh giới module chỉ giữ được khi có dependency rule và công cụ kiểm | QA-001: transaction trong một DB. QA-003: kiểm quyền tại một chỗ. Hợp với một người |
| Client + BaaS | Ra nhanh; BaaS lo auth và DB | Luật nghiệp vụ dễ rơi xuống client hoặc thành nhiều function rời; khó kiểm luật trải nhiều aggregate | QA-003 khó: phải dựa vào row-level security cho mọi luật phân quyền theo phạm vi |
| Microservices theo module | Tách deploy, tách scale từng module | Nhất quán dữ liệu giữa service, nhiều deploy, chi phí vượt ngân sách | QA-001 khó: số dư phép và chốt kỳ cần giao dịch phân tán |

## Consequences

- **Easier:** luật trải nhiều aggregate dùng transaction của DB; một pipeline CI và một deploy.
- **Harder:** phải kiểm dependency rule giữa module bằng công cụ, nếu không ranh giới sẽ mờ dần.
- **Follow-up:** chọn công cụ kiểm import giữa module khi viết conventions (Issue #13).

## Revisit when

Một module cần scale hoặc deploy riêng, ví dụ tính lương vượt QA-004 khi quy mô vượt 1.000 nhân viên; hoặc có team
thứ hai làm song song.
