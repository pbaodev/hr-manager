# Decisions

> Mỗi quyết định khó đảo ngược có một ADR (Architecture Decision Record) trong thư mục này, viết theo
> [_template.md](_template.md). Khi tạo ADR, thêm một dòng vào Index; khi ADR đổi Status, sửa dòng đó.

## When to write an ADR

- Phase 1: spike dẫn tới một quyết định khó đảo ngược.
- Phase 3: architecture style, stack, lưu trữ dữ liệu, auth, hosting, và cách đáp ứng từng architecture driver.
- Feature loop: quyết định khó đảo ngược của một feature, ví dụ đổi cách lưu một loại dữ liệu.
- Đổi một quyết định đã `Accepted`: viết ADR mới; ADR cũ chuyển sang `Superseded by ADR-NNNN`.

Lựa chọn dễ đổi lại thì không cần ADR, ví dụ một thư viện chỉ dùng trong một module. Cách viết và ví dụ ở mục ADRs của
[design guide](../playbook/design.md).

## Index

Cột Options not chosen giúp tìm lại phương án đã cân nhắc mà không phải mở từng ADR.

ADR-0001 tới ADR-0006 được viết cho phạm vi cũ và đã bỏ ngày 2026-10-31 (#41), để chọn lại stack ở Phase 3 sau
prototype. Nội dung đầy đủ nằm ở tag `design-v0`. Các dòng dưới đây giữ lại để link cũ vẫn có nghĩa; ADR mới đánh số từ
0007.

| ADR | Title | Status | Date | Drivers | Options not chosen |
|---|---|---|---|---|---|
| 0001 | Modular monolith gồm một backend và một SPA | (removed, #41) | 2026-10-30 | QA-001, QA-003, QA-004 | Client + BaaS; microservices |
| 0002 | Python FastAPI cho backend, React TypeScript cho frontend | (removed, #41) | 2026-10-30 | QA-002, QA-003, QA-004 | NestJS + React; Spring Boot + React; Next.js full-stack |
| 0003 | PostgreSQL là nơi lưu dữ liệu duy nhất | (removed, #41) | 2026-10-30 | QA-001, QA-002, QA-005 | MySQL; SQLite |
| 0004 | Xác thực tự làm bằng JWT ngắn hạn và refresh token lưu DB | (removed, #41) | 2026-10-30 | QA-003 | Session lưu DB; dịch vụ auth ngoài |
| 0005 | Render cho production, gói miễn phí cho staging | (removed, #41) | 2026-10-30 | QA-004, QA-005 | Railway; app trên Render với DB trên Neon |
| 0006 | Mantine, TanStack Query, openapi-fetch và React Router cho frontend | (removed, #41) | 2026-10-30 | QA-003 | shadcn/ui; Ant Design; SWR; Orval; TanStack Router |
| [0007](0007-architecture-style.md) | Modular monolith gồm một backend và một web client | Proposed | 2026-11-03 | QA-001, QA-003, QA-007 | Client và BaaS; serverless functions |
| [0008](0008-stack.md) | Ngôn ngữ và framework cho backend và web client | Proposed | 2026-11-03 | QA-002, QA-006, QA-010, QA-011 | TypeScript cả hai phía; Next.js full-stack; Spring Boot và React |
| [0009](0009-data-storage.md) | PostgreSQL là nơi lưu dữ liệu duy nhất | Proposed | 2026-11-03 | QA-001, QA-005 | MySQL; SQLite |
| [0010](0010-authentication.md) | Đăng nhập bằng mã nhân viên, phiên lưu ở server | Proposed | 2026-11-03 | QA-003, QA-007 | JWT và refresh token; dịch vụ auth ngoài |
| [0011](0011-hosting.md) | Nơi chạy staging và production | Proposed | 2026-11-03 | QA-005 | Chưa chọn: PaaS cố định giá; PaaS theo mức dùng; VPS tự quản; cloud trong nước |
