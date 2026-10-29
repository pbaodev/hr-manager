---
name: Change Request
about: Đổi hành vi, interface, dữ liệu, kiến trúc hoặc phạm vi đã chốt
title: "CR: "
labels: "type:change-request"
assignees: ""
---

> Dùng khi thay đổi thuộc loại cần CR trong `docs/playbook/change-control.md`. Mã CR là `CR-` cộng số Issue này.
> Thêm tính năng mới thì dùng Issue Feature thay vì CR.

## Change

- **Current:** [hành vi, interface hoặc quyết định hiện tại; dẫn tới requirements, domain, tài liệu thiết kế hoặc ADR]
- **Proposed:** [thay đổi đề xuất]
- **Why:** [nhu cầu hoặc bằng chứng]

## Type

- [ ] Behavior
- [ ] Interface or data
- [ ] Architecture (kèm ADR mới)
- [ ] Scope

## Impact

| Area | Impact |
|---|---|
| Stories and rules | [US-xxx, BR-xxx, EC-xxx] |
| Design | [data, API, components, flows; ADR bị thay thế] |
| Data already stored | [migration, dữ liệu cũ xử lý thế nào] |
| Cost and schedule | [ước tính] |

## Options

| Option | Pros | Cons |
|---|---|---|
| [phương án đề xuất] | | |
| Không đổi | | |

## Verification

[Sau khi đổi thì kiểm thế nào; có vấn đề thì quay lại bằng cách nào.]

## Decision

- **Decision:** [Approved | Rejected | Deferred], [YYYY-MM-DD]
- **Cool-off review:** [ngày đọc lại; bắt buộc với Interface, Architecture, Scope]
- **Reason:** [một câu]
- **Follow-up PR:** [#PR cập nhật tài liệu, code và test]
