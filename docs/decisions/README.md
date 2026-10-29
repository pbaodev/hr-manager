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

| ADR | Title | Status | Date | Drivers | Options not chosen |
|---|---|---|---|---|---|
| [0001](0001-architecture-style.md) | Modular monolith gồm một backend và một SPA | Accepted | 2026-10-30 | QA-001, QA-003, QA-004 | Client + BaaS; microservices |
| [0002](0002-stack.md) | Python FastAPI cho backend, React TypeScript cho frontend | Accepted | 2026-10-30 | QA-002, QA-003, QA-004 | NestJS + React; Spring Boot + React; Next.js full-stack |
| [0003](0003-data-store.md) | PostgreSQL là nơi lưu dữ liệu duy nhất | Accepted | 2026-10-30 | QA-001, QA-002, QA-005 | MySQL; SQLite |
| [0004](0004-authentication.md) | Xác thực tự làm bằng JWT ngắn hạn và refresh token lưu DB | Accepted | 2026-10-30 | QA-003 | Session lưu DB; dịch vụ auth ngoài |
| [0005](0005-hosting.md) | Render cho production, gói miễn phí cho staging | Accepted | 2026-10-30 | QA-004, QA-005 | Railway; app trên Render với DB trên Neon |
