# Decisions

> Mỗi quyết định khó đảo ngược có một ADR (Architecture Decision Record) trong thư mục này, viết theo
> [_template.md](_template.md). Khi tạo ADR, thêm một dòng vào Index; khi ADR đổi Status, sửa dòng đó. Dòng in nghiêng
> là ví dụ, xóa khi điền.

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
| *0004* | *Chặn trùng lịch bằng exclusion constraint* | *Accepted* | *[YYYY-MM-DD]* | *QA-002, BR-001* | *Kiểm trùng ở tầng app trong transaction; khóa theo phòng* |
