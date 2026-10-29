---
name: Bug
about: Hành vi khác với requirements, domain, tài liệu thiết kế hoặc kết quả mong đợi
title: ""
labels: "type:bug"
assignees: ""
---

> Không đưa secret hay dữ liệu thật của người dùng vào Issue. Che thông tin nhạy cảm trước khi dán log hoặc ảnh.

## Impact

- **Severity:** [S1 | S2 | S3 | S4], theo Defect severity trong `docs/testing.md`. S1 là sự cố Severe ở Phase 5
- **Who and what:** [ai gặp lỗi, việc gì bị ảnh hưởng]

## Steps to reproduce

1. [bước]

[Lỗi không xảy ra mọi lần thì ghi tần suất.]

## Expected

[Hành vi đúng, dẫn tới US-xxx, BR-xxx, EC-xxx hoặc mục thiết kế.]

## Actual

[Kết quả quan sát được, kèm log hoặc ảnh đã che thông tin nhạy cảm.]

## Environment

- **Environment:** [local | staging | production]
- **Version:** [commit hoặc tag]
- **AI:** [model ID, version prompt; bỏ nếu lỗi không liên quan tới tính năng AI]

## Notes

[Nguyên nhân nghi ngờ. Lỗi do thiếu edge case thì thêm EC-xxx vào domain; sửa lỗi mà phải đổi hành vi đã chốt thì mở
CR. Lỗi hành vi AI: ẩn danh rồi thêm ca vào smoke set.]
