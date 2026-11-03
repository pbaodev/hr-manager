# ADR-0009: PostgreSQL là nơi lưu dữ liệu duy nhất

- **Status:** Accepted
- **Date:** 2026-11-03
- **Reviewed:** 2026-11-03: chủ dự án chọn phương án ở #8; chưa review nguội, chưa AI review
- **Drivers:** QA-001, QA-005; BR-016, BR-025; ràng buộc hạ tầng $10–25 mỗi tháng
- **Related:** [ARCHITECTURE](../../ARCHITECTURE.md#architecture-drivers), [data](../design/data.md), #8, #9, ADR-0011

## Context

- Số dư phép không âm và giới hạn làm thêm không vượt khi hai thao tác tới cùng lúc (QA-001).
- Nhiều dữ liệu có ngày hiệu lực và không được chồng nhau: quá trình công tác (BR-016), hợp đồng (BR-025), bản ghi
  lương. Cơ cấu tổ chức phải xem lại được tại một ngày bất kỳ.
- Mất tối đa 24 giờ dữ liệu, chạy lại trong 4 giờ (QA-005).
- AI HR Assistant tìm trong các mục quy chế để dẫn nguồn (BR-200); cách tìm chọn ở [ai](../design/ai.md).
- Quy mô 300 nhân viên, dữ liệu nhiều năm: dung lượng nhỏ, một DB là đủ.

## Decision

Chủ dự án chọn ngày 2026-11-03: một DB PostgreSQL managed cho mọi dữ liệu, gồm cả hàng đợi job và chỉ mục tìm kiếm
quy chế. Khoảng ngày hiệu lực lưu bằng kiểu range; luật không chồng giữ bằng exclusion constraint.

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| PostgreSQL | Range và exclusion constraint giữ luật không chồng ngay trong DB; khóa dòng khi ghi; tìm kiếm full-text, có extension vector khi cần; nhiều nơi cho managed kèm backup | Exclusion constraint và range gắn với PostgreSQL; test cần DB thật | QA-001, BR-016, BR-025: đạt bằng cơ chế của DB; QA-005: đạt bằng backup của gói managed |
| MySQL | Phổ biến, nhiều nơi host | Không có range hay exclusion constraint; luật không chồng phải kiểm ở app trong transaction | QA-001: đạt bằng khóa ở app; BR-016, BR-025: dễ sót khi thêm đường ghi mới |
| SQLite | Một file, không phải vận hành server DB; backup là chép file | Một luồng ghi mỗi lúc; nhiều PaaS không giữ file lâu dài; không có exclusion constraint | QA-001: đạt nhờ khóa toàn DB nhưng hạn chế đồng thời; QA-005: tự lo backup |

## Consequences

- **Easier:** invariant về thời gian và số dư nằm trong DB, mọi đường ghi đều bị chặn như nhau; không cần thêm dịch vụ
  hàng đợi hay tìm kiếm.
- **Harder:** migration và test gắn với PostgreSQL; chọn hosting phải có PostgreSQL managed.
- **Follow-up:** ghi constraint, index và transaction theo aggregate ở [data](../design/data.md) (#9); diễn tập khôi
  phục theo QA-005 ở runbook.

## Revisit when

Hosting được chọn không có PostgreSQL managed trong ngân sách; hoặc tìm kiếm quy chế cần chất lượng mà PostgreSQL không
đạt trong eval của QA-011.
