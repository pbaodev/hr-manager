# ADR-0003: PostgreSQL là nơi lưu dữ liệu duy nhất

- **Status:** Accepted
- **Date:** 2026-10-30
- **Reviewed:** 2026-10-30: chủ dự án đồng ý
- **Drivers:** QA-001, QA-002, QA-005; luật dữ liệu có khoảng hiệu lực (BR-011, BR-016, BR-025, BR-093)
- **Related:** ADR-0001, [domain](../analysis/domain.md#aggregates-and-invariants), [data design](../design/data.md)

## Context

Nhiều invariant là "các khoảng thời gian không chồng nhau": quá trình công tác, hợp đồng, bổ nhiệm trưởng, bản ghi lương,
gán ca. Số dư phép phải không âm khi hai đơn được duyệt cùng lúc (EC-024), và chốt bảng lương chỉ được một lần (EC-072).
Dữ liệu là quan hệ, quy mô nhỏ (A-011). Không có nhu cầu tìm kiếm toàn văn hay lưu file lớn trong baseline.

## Decision

- PostgreSQL 16 trở lên, một database cho cả hệ thống. Không thêm cache hay hàng đợi trong baseline.
- Dùng kiểu `daterange` và exclusion constraint (extension `btree_gist`) cho invariant không chồng khoảng; `CHECK`,
  `UNIQUE`, khóa ngoại cho invariant trong aggregate.
- Cách chặn tranh chấp cho từng luật trải nhiều aggregate, như khóa dòng hay mức isolation, chọn ở
  [data design](../design/data.md) (Issue #9).
- Session refresh token và hàng đợi thông báo, nếu cần, cũng nằm trong PostgreSQL.

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| PostgreSQL | `daterange`, exclusion constraint, `SELECT ... FOR UPDATE`, transaction mạnh; mọi PaaS đều có bản managed | Test cần DB thật, không chạy được trên SQLite | QA-001: đạt bằng constraint và khóa của DB. QA-005: managed có backup |
| MySQL | Phổ biến, có bản managed | Không có kiểu range và exclusion constraint; chặn chồng khoảng phải kiểm ở app | QA-001: đạt nếu mọi đường ghi đều khóa đúng; dễ sót |
| SQLite | Không cần server, rẻ | Một người ghi tại một thời điểm; ít lựa chọn backup managed | QA-005 khó; không hợp với PaaS có filesystem tạm |

## Consequences

- **Easier:** DB tự chặn chồng khoảng hiệu lực kể cả khi có lỗi ở app; truy vấn "tại ngày D" dùng toán tử range.
- **Harder:** test tích hợp phải chạy PostgreSQL thật, ở local và trong CI.
- **Follow-up:** chọn nhà cung cấp và cách backup ở ADR-0005; viết migration đầu tiên ở Issue #9.

## Revisit when

Cần tìm kiếm toàn văn nặng, lưu file đính kèm, hoặc tải vượt một instance PostgreSQL.
