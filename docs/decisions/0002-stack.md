# ADR-0002: Python FastAPI cho backend, React TypeScript cho frontend

- **Status:** Accepted
- **Date:** 2026-10-30
- **Reviewed:** 2026-10-30: chủ dự án chọn phương án
- **Drivers:** QA-002, QA-003, QA-004; một người làm cùng coding agent; M6 có tính năng AI
- **Related:** ADR-0001, [project](../project/project.md#goals)

## Context

Backend cần REST API có OpenAPI (check `contract`), logic nghiệp vụ nặng về ngày tháng và tiền, và job theo lịch. Tiền
phải tính chính xác tới đồng với luật làm tròn riêng (BR-114), nên kiểu số thực dấu phẩy động không dùng được. M6 sẽ
thêm tính năng AI.

## Decision

- **Backend:** Python 3.13, FastAPI, Pydantic v2 để validate ở biên, SQLAlchemy 2.0 và Alembic cho truy cập dữ liệu và
  migration, `uv` quản lý môi trường và dependency.
- **Tiền:** tính bằng `decimal.Decimal` trong code; lưu trong DB là số nguyên đồng. Không dùng `float` cho tiền, giờ
  công hay hệ số.
- **Frontend:** React, TypeScript, Vite. Client API sinh từ `contracts/openapi.yaml`. Thư viện UI chọn ở Issue #12.
- **Công cụ kiểm:** pytest, ruff, mypy cho backend; ESLint, Vitest cho frontend. Cấu hình ở Issue #14.

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| Python FastAPI + React | `Decimal` có sẵn; sinh OpenAPI tự động; Pydantic validate chặt; hệ sinh thái AI tốt nhất cho M6 | Hai ngôn ngữ; FastAPI ít khuôn khổ module, phải tự giữ cấu trúc | QA-002: `Decimal`. QA-003: dependency injection để kiểm quyền mọi route |
| TypeScript NestJS + React | Một ngôn ngữ; module của NestJS khớp modular monolith | Tiền cần thư viện decimal ngoài; AI ở M6 ít thư viện hơn | QA-002: đạt nếu luôn dùng thư viện decimal |
| Kotlin Spring Boot + React | Mạnh cho domain và transaction; `BigDecimal` | Hai ngôn ngữ; vòng sửa chậm; tốn RAM ở gói hosting rẻ | QA-004 đạt; chi phí hosting cao hơn |
| Next.js full-stack | Một project, ra nhanh nhất | Khó giữ API contract-first và ranh giới module; job theo lịch cần cron ngoài | QA-003 dễ sót khi logic nằm lẫn trong giao diện |

## Consequences

- **Easier:** tính tiền chính xác; viết test luật lương bằng bảng số liệu; thêm AI ở M6 cùng ngôn ngữ backend.
- **Harder:** kiểu dữ liệu ở hai đầu phải giữ khớp, nên client frontend luôn sinh lại từ contract; Python chậm hơn khi
  tính lương hàng loạt, cần đo theo QA-004.
- **Follow-up:** quyết định contract-first hay code-first cho OpenAPI ở Issue #10; đo thời gian tính 300 phiếu lương ở
  M4.

## Revisit when

Tính bảng lương 300 phiếu vượt 30 giây sau khi đã tối ưu truy vấn; hoặc có người thứ hai chỉ quen một ngôn ngữ.
