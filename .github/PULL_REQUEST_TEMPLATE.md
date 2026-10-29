## Summary

[Đổi gì và vì sao, 1–3 câu.]

## Links

- **Task:** Closes [#issue]; PR trung gian của Issue tài liệu ghi Refs [#issue]
- **Feature:** [#issue; bỏ nếu không có]
- **Docs:** [mục SPEC, tài liệu thiết kế, ADR liên quan]
- **CR:** [CR-xxx nếu PR đổi hành vi đã chốt; bỏ nếu không]

## Risk

- [ ] PR đụng tới tiền, quyền, dữ liệu nhạy cảm, migration, contract, prompt hoặc model, và đã review nguội trước khi
      merge

## Design impact

- [ ] Không đổi thiết kế
- [ ] Đã cập nhật tài liệu thiết kế, contract và Traceability trong SPEC trong PR này
- [ ] Code làm khác thiết kế và chưa sửa tài liệu; đã mở Issue: [#issue]

## Verification

| Check | Environment | Result |
|---|---|---|
| `make check` | [local / CI] | |
| AI review | — | [đã sửa hết Critical, Required] |
| [luồng đã thử tay] | [local / staging] | |

**AI changes:** eval-lite trước và sau. Bỏ phần này nếu PR không đụng tính năng AI.

- **Smoke set and version:** [đường dẫn, số ca] · **Model and prompt:** [model ID, version prompt]

| Metric | Before | After |
|---|---|---|
| | | |

**Not verified:** [phần chưa kiểm và lý do]

## Deploy notes

[Migration, config, feature flag, việc cần theo dõi sau khi deploy. Bỏ nếu không có.]
