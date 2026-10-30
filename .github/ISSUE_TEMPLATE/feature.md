---
name: Feature
about: Một tính năng gồm một hoặc vài user story; chạy mini Analysis và Design trước khi chia Task
title: "feat: "
labels: "type:feature"
assignees: ""
---

> Feature đi theo Feature loop ở Phase 4 trong `docs/playbook/phases.md`. Task của feature được tạo thành sub-issue của
> Issue này.

## Goal

[Người dùng làm được gì sau feature này, 1–2 câu.]

## Analysis delta

- **Stories:** [US-xxx mới hoặc sửa trong `docs/analysis/stories.md`; đạt INVEST]
- **Use cases:** [UC-xxx; bỏ nếu không có]
- **Rules and edge cases:** [BR-xxx, EC-xxx mới hoặc sửa]
- **Quality attributes:** [QA-xxx bị ảnh hưởng; bỏ nếu không có]
- **Open questions:** [Q-xxx; bỏ nếu không có]

## Design delta

Đánh dấu phần bị ảnh hưởng và tóm tắt một dòng; tài liệu chi tiết được sửa trong PR.

- [ ] Data: [bảng, constraint, migration]
- [ ] API: [operation mới hoặc đổi]
- [ ] Components: [module mới, đổi dependency]
- [ ] Flows: [sequence diagram mới hoặc sửa]
- [ ] AI: [prompt, model, contract]
- [ ] ADR: [quyết định khó đảo ngược]
- [ ] Không đổi thiết kế, vì: [lý do]

## Review

- [ ] Đã chạy phần liên quan của Analysis checklist trong `docs/playbook/analysis.md`
- [ ] Đã chạy phần liên quan của Design review checklist trong `docs/playbook/design.md`
- [ ] Đã review nguội, khi feature đụng data, API hoặc kiến trúc
- [ ] Traceability trong SPEC đã cập nhật, Status `Designed`
- [ ] Ca thử tay `TC-xxx` đã thêm vào `docs/build/testing.md`, nếu story cần

## Tasks

[Sub-issue. Task đầu thường là tài liệu delta, migration và contract.]

## Done when

- [ ] Acceptance criteria của các story đạt khi thử trên [staging / local]
- [ ] Traceability của các story ở `Implemented`; mục Unreleased trong `CHANGELOG.md` đã ghi thay đổi
