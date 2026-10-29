# ADR-[NNNN]: [quyết định, viết ngắn]

- **Status:** [Proposed | Accepted | Rejected | Superseded by ADR-NNNN]
- **Date:** [YYYY-MM-DD]
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Drivers:** [QA-xxx, ràng buộc, BR-xxx mà quyết định này phục vụ]
- **Related:** [Q-xxx, A-xxx, Issue Spike, link tài liệu]

> Mỗi quyết định khó đảo ngược có một ADR. Đặt tên file `NNNN-short-title.md` trong thư mục này, số tăng dần; ADR đầu
> tiên thường là `0001-architecture-style.md`. Tạo xong thì thêm một dòng vào [Index](README.md), ghi cả phương án
> không chọn. ADR đã `Accepted` thì không sửa mục Decision; muốn đổi thì viết ADR mới thay thế, theo
> [change-control.md](../playbook/change-control.md). Dòng in nghiêng là ví dụ, xóa khi điền.

## Context

[Cần quyết chuyện gì, có ràng buộc và bằng chứng nào. Phân biệt điều đã biết với assumption.]

## Decision

[Chọn gì và áp dụng cho phạm vi nào, nói cụ thể.]

## Options considered

Ít nhất hai phương án thật. Cột Fit with drivers so các phương án theo quality attribute và ràng buộc ở dòng Drivers.

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| *Exclusion constraint trong DB* | *DB chặn trùng kể cả khi hai request tới cùng lúc* | *Gắn với một loại DB; test cần DB thật* | *QA-002: đạt bằng cơ chế của DB* |
| *Kiểm trùng ở tầng app trong transaction* | *Không phụ thuộc loại DB* | *Cần khóa hoặc isolation cao; dễ sót khi thêm đường ghi mới* | *QA-002: đạt nếu mọi đường ghi đều khóa* |

## Consequences

- **Easier:** [việc gì dễ hơn]
- **Harder:** [việc gì khó hơn, phải đánh đổi gì]
- **Follow-up:** [việc cần làm tiếp; cách kiểm các assumption quan trọng]

## Revisit when

[Điều kiện khiến quyết định này cần xem lại. Ví dụ: phải chạy trên một DB không hỗ trợ exclusion constraint; số lịch
đặt vượt 1 triệu.]
