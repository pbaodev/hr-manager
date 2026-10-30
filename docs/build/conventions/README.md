# Conventions

> Thư mục này ghi những quy tắc viết code mà linter, formatter và type checker không tự kiểm được. Quy tắc máy kiểm
> được thì cấu hình vào công cụ, không ghi ở đây. Template không chọn sẵn stack hay quy tắc nào; thêm file khi có quy
> tắc cần giữ.

## When to add one

Thêm convention khi tự sửa cùng một lỗi nhiều lần, hoặc agent sai cùng một kiểu nhiều lần. Ví dụ: cách xử lý lỗi, cách
đặt tên migration, cách viết test cho business rule. Dependency rule giữa các module nằm ở
[components](../../design/components.md), không ghi lại ở đây.

## How

1. Copy [_template.md](_template.md) và đặt tên theo phạm vi, ví dụ `backend.md`, `error-handling.md`.
2. Mở PR. Khi merge, Status chuyển sang `Accepted`.
3. Thêm một dòng vào Index.

## Index

| File | Scope | Status |
|---|---|---|
| | | |

Thiết kế hệ thống nằm ở [ARCHITECTURE.md](../../../ARCHITECTURE.md). Cách thiết kế và đo tính năng AI nằm ở
[AI components guide](../../playbook/ai-components.md).
