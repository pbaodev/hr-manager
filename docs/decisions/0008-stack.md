# ADR-0008: Ngôn ngữ và framework cho backend và web client

- **Status:** Proposed
- **Date:** 2026-11-03
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Drivers:** QA-002, QA-006, QA-010, QA-011; ràng buộc một người làm cùng coding agent
- **Related:** [ARCHITECTURE](../../ARCHITECTURE.md#architecture-drivers), #8, ADR-0007, [ui](../design/ui.md#design-sources)

## Context

- Lương phải khớp tính tay tới từng đồng (QA-002): cần kiểu số thập phân chính xác và làm tròn theo BR-114.
- Ba tính năng AI cần eval chạy khi đổi prompt, model hay pipeline (QA-006, QA-010, QA-011), gồm phần code chấm và
  phần LLM chấm theo rubric.
- Design system của prototype viết bằng React ([ui](../design/ui.md#design-sources)); web client dùng React thì chuyển
  component sang code ít tốn công nhất.
- Một người làm cùng coding agent: ngôn ngữ và framework phổ biến, có type, có test nhanh.
- Nhập file chấm công khoảng 20.000 dòng dưới 60 giây và xuất file (QA-004, `M/M`): ngôn ngữ nào ở dưới cũng đạt.

## Decision

Đề xuất, chờ chủ dự án chọn: backend Python với FastAPI; web client React và TypeScript. Client gọi backend qua
contract OpenAPI, type của client sinh từ contract.

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| Python FastAPI; React TypeScript | `Decimal` có sẵn trong thư viện chuẩn; hệ sinh thái eval và xử lý dữ liệu mạnh; FastAPI sinh OpenAPI từ code | Hai ngôn ngữ; type giữa hai bên phải sinh từ contract | QA-002: đạt bằng `Decimal`; QA-006, QA-010, QA-011: thuận cho eval |
| TypeScript cả hai phía: Node với NestJS hoặc Fastify; React | Một ngôn ngữ; dùng chung type; agent làm một kiểu code | Số thập phân cần thư viện như decimal.js, dễ lẫn với `number`; công cụ eval ít hơn Python | QA-002: đạt nếu cấm `number` cho tiền bằng lint; QA-006 tới QA-011: đạt, ít công cụ sẵn |
| Next.js full-stack | Một framework cho giao diện và API; route và component cùng chỗ | Job theo lịch và tính lương chạy dài cần tiến trình riêng ngoài framework; logic nghiệp vụ dễ trộn với code giao diện | QA-002: như TypeScript; ADR-0007: ranh giới module khó giữ hơn |
| Kotlin hoặc Java với Spring Boot; React | `BigDecimal`, transaction và type chặt; framework trưởng thành | Nhiều code khung, chạy và test chậm hơn cho một người | QA-002: đạt; ràng buộc một người: tốn công nhất |

## Consequences

- **Easier:** tiền tính bằng `Decimal` từ đầu tới cuối; eval AI viết cùng ngôn ngữ với backend; component của design
  system chuyển sang React.
- **Harder:** giữ hai bộ công cụ, hai bộ lint và test; đổi contract thì phải sinh lại type của client.
- **Follow-up:** chọn thư viện frontend, như router, quản lý dữ liệu từ server và form, ở ADR riêng nếu khó đổi lại;
  cấu hình `make check` cho cả hai phía ở #14.

## Revisit when

Eval AI chuyển sang dịch vụ ngoài không phụ thuộc ngôn ngữ; hoặc chi phí giữ hai ngôn ngữ lớn hơn lợi ích của `Decimal`
và công cụ eval.
